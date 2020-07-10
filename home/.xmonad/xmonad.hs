-- Core ------------------------------------------------------------------------
import XMonad -- core libraries
import XMonad.Config.Desktop
import System.Exit (exitSuccess)

-- Hooks -----------------------------------------------------------------------
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.XPropManage
import XMonad.ManageHook

-- Utilities -------------------------------------------------------------------
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad

import Foreign.C.Types (CLong)
import Graphics.X11.Xlib.Extras

import qualified XMonad.StackSet as W

-- Config Vars -----------------------------------------------------------------

myTerminal :: String
myTerminal = "alacritty"

myWorkspaces :: [String]
myWorkspaces = 
  [ "1:web", "2:dv1", "3:dv2",
    "4:dv3", "5:sys", "6:ct1",
    "7:ct2", "8:mus", "9:msc",
    "0:ms2", "-",     "="     

    , "dev1", "dev2", "dev3", "dev4", "dev5"
    , "dev6", "dev7", "dev8", "dev9", "dev10"

  ]

myModMask :: KeyMask
myModMask = mod4Mask

myBrowser :: String
myBrowser = "chromium"

myLauncher :: String
myLauncher = "rofi -show drun -lines 4"

myBorderWidth :: Dimension
myBorderWidth = 2
myBorderColor :: String
myBorderColor = "#161C1F"
myBorderActiveColor :: String
myBorderActiveColor = "#E6A3DC"

-- Polybar ---------------------------------------------------------------------

wsOutput wsStr = do
  io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

polybarPP = dynamicLogWithPP $ def {
  ppCurrent = wrap ("%{F#9C71C7}[%{F-}%{F#BEB3CD}") "%{F-}%{F#9C71C7}]%{F-}"
  , ppHidden = wrap ("%{F" ++ "#BEB3CD" ++ "} ") " %{F-}"
  , ppHiddenNoWindows = wrap ("%{F" ++ "#6B5A68" ++ "} ") " %{F-}"
  , ppUrgent = wrap ("%{F#8c414f}<%{F-}%{F#BEB3CD}") "%{F-}%{F#8c414f}>%{F-}"
  , ppSep = "  "
  , ppLayout = wrap ("%{F#9c71C7}") "%{F-}"
  , ppTitle = (\str -> "")
  -- , ppSort = fmap (.namedScratchpadFilterOutWorkspace) $ ppSort defaultPP
  , ppOutput = wsOutput
  }

-- Autostart -------------------------------------------------------------------

setFullscreenSupport :: X ()
setFullscreenSupport = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom ["_NET_WM_STATE_HIDDEN"
                         ,"_NET_WM_STATE_FULLSCREEN" -- XXX Copy-pasted to add this line
                         ,"_NET_NUMBER_OF_DESKTOPS"
                         ,"_NET_CLIENT_LIST"
                         ,"_NET_CLIENT_LIST_STACKING"
                         ,"_NET_CURRENT_DESKTOP"
                         ,"_NET_DESKTOP_NAMES"
                         ,"_NET_ACTIVE_WINDOW"
                         ,"_NET_WM_DESKTOP"
                         ,"_NET_WM_STRUT"
                         ]
    io $ changeProperty32 dpy r a c propModeReplace (fmap fromIntegral supp)

myStartupHook :: X ()
myStartupHook = do
  spawn "feh --bg-fill --no-fehbg ~/.wallpaper"
  spawn "picom &"
  spawn "dunst &"
  spawn "sh ~/.config/polybar/launch.sh &"
  spawn "lxqt-policykit-agent"
  spawn "pkill dunst; dunst &"
  spawn "xsetroot -cursor_name left_ptr"
  setFullscreenSupport

-- Manage Hook -----------------------------------------------------------------

getProp :: Atom -> Window -> X (Maybe [CLong])
getProp a w = withDisplay $ \dpy -> io $ getWindowProperty32 dpy a w

checkDialog :: Query Bool
checkDialog = ask >>= \w -> liftX $ do
                a <- getAtom "_NET_WM_WINDOW_TYPE"
                dialog <- getAtom "_NET_WM_WINDOW_TYPE_DIALOG"
                mbr <- getProp a w
                case mbr of
                  Just [r] -> return $elem (fromIntegral r) [dialog]
                  _ -> return False

checkNotif :: Query Bool
checkNotif = ask >>= \w -> liftX $ do
               a <- getAtom "_NET_WM_WINDOW_TYPE"
               dialog <- getAtom "_NET_WM_WINDOW_TYPE_NOTIFICATION"
               mbr <- getProp a w
               case mbr of
                 Just [r] -> return $elem (fromIntegral r) [dialog]
                 _ -> return False


myManageHook :: ManageHook
myManageHook = composeAll
  [ checkDialog --> doCenterFloat
  , checkNotif --> doSideFloat NE
  , className =? "Pavucontrol" --> doFloat
  , manageDocks
  ]

-- Scratchpads -----------------------------------------------------------------

myScratchpads =
  -- Run nmcli in alacritty
  [ NS "nmcli" "alacritty -t 'nmtui' -e 'nmtui'"
      (title =? "nmtui")
      (customFloating $ center 0.5 0.5)

  -- Run gotop
  , NS "gotop" "alacritty --class gotop -e gotop"
      (resource =? "gotop")
      (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7)

  -- Run pavucontrol
  , NS "pavucontrol" "pavucontrol"
      (className =? "pavucontrol")
      (customFloating $ center 0.5 0.5)
  ]
  where
    role = stringProperty "WM_WINDOW_ROLE"
    center w h = W.RationalRect ((1 - w) / 2) ((1 - h) / 2) w h

-- Keybinds --------------------------------------------------------------------

myKeygen :: String -> String -> String -> [(String, X ())]
myKeygen t n w =
  [ ("M-w " ++ t ++ " " ++ n, windows $ W.greedyView w)
  , ("M-S-w " ++ t ++ " " ++ n, windows $ W.shift w)
  ]

devKeys :: [(String, X ())]
devKeys = concat (map (\i -> myKeygen "d" i ("dev"++i)) (map show [1..9]))

myKeys :: [(String, X ())]
myKeys =
  -- Xmonad
  [ ("M-C-r", spawn "xmonad --recompile") -- Recompile config
  , ("M-S-r", spawn "xmonad --restart")   -- Restart WM
  , ("M-S-q", io exitSuccess)             -- Quit xmonad

  -- Open my terminal
  , ("M-<Return>", spawn myTerminal)

  -- App Launchers
  , ("M-p", spawn myLauncher) -- Rofi
  , ("<Print>", spawn "flameshot gui")

  , ("M-x b", spawn "chromium --profile-directory=\"Default\"")
  , ("M-x w", spawn "chromium --profile-directory=\"work\"")
  , ("M-x d", spawn "Discord")
  , ("M-x s", spawn "spotify")
  , ("M-x t", spawn "teams")

  -- Multimedia
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
  , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")

  -- Scratchpads
  , ("M-<F12>", namedScratchpadAction myScratchpads "nmcli")
  , ("M-<F11>", namedScratchpadAction myScratchpads "gotop")
  , ("M-<F10>", namedScratchpadAction myScratchpads "pavucontrol")
  
  ] ++ devKeys

-- Entrypoint ------------------------------------------------------------------

main :: IO ()
main = xmonad $ myConfig

myConfig = desktopConfig
  { modMask = myModMask
  , borderWidth = myBorderWidth
  , normalBorderColor = myBorderColor
  , focusedBorderColor = myBorderActiveColor
  , terminal = myTerminal
  , workspaces = myWorkspaces
  , manageHook = myManageHook <+>
      namedScratchpadManageHook myScratchpads <+>
      manageHook desktopConfig

  , startupHook = myStartupHook
  , logHook = polybarPP
  } `additionalKeysP` myKeys
