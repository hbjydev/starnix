{ pkgs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      programs.firefox.enable = true;

      programs.firefox.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        honey
        https-everywhere
      ];

      programs.firefox.profiles =
        let defaultSettings = {
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.warnOnClose" = false;
          "browser.startup.homepage" = "https://reddit.com";
          "browser.urlbar.update1" = false;
          "browser.urlbar.placeholderName" = "Search...";
          "browser.urlbar.placeholderName.private" = "Search...";
          "browser.uidensity" = 1;
          "permissions.default.desktop-notification" = 2;
          "ui.context_menus.after_mouseup" = true;
          "svg.context-properties.content.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "signon.rememberSignons" = false;
          "browser.startup.page" = 3;
          "browser.urlbar.suggest.history" = false;
          "devtools.toolbox.host" = "right";
          "general.smoothScroll" = false;
          "print.print_footerleft" = "";
          "print.print_footerright" = "";
          "print.print_headerleft" = "";
          "print.print_headerright" = "";
        };
        in
        {
          work = {
            id = 0;
            settings = defaultSettings // {
              "browser.startup.homepage" = "https://weekly.nixos.org/";
            };
          };

          chill = {
            id = 1;
            settings = defaultSettings // {
              "browser.startup.homepage" = "https://reddit.com/";
            };
          };
        };
    };
  };
}
