#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, pkgs, lib, vars, ... }:
let
  stableTarball =
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz;
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      stable = import stableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  networking.networkmanager.enable = true; # nmcli for wi-fi
  networking.wireless.enable = lib.mkForce false;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.xserver = {
    displayManager.lightdm = {
      autoLogin = { enable = true; user = vars.user; };
    };
  };

  services.mingetty.helpLine = lib.mkForce ''
    The "root" account has "id" as its password.
    Type `i' to print system information.

                         .;+itIYIIYIIYItt+;:                      
                    =tXVVXItt+;=;;=+itIYVVXIi:                  
                 ;YVXXt=:               .;tYXXX+                
              .tVXVt;                       .iXXVI:             
             tRXX;                        .;;  ;YVVY:           
           ;RXV;                            +RR+..YVRt          
         .XXR;                           :;.  ;BBY.:VXR;        
        ;RYX                              :XBY; tBBi tVR+       
       ;RV+                             :;  :RMB+;BMB.;RXt      
      ;RR;                               ;RR+.tBMBiBMB::RXt     
     :RV;                             .+;. iBBY;BMMBMMB.:RXi    
     RYt                                =BBi:BMBXBMMMBY. ;RR;   
    YtV                               +Y+:tMBIBMMBMR=     iIR   
   :RR.                        .::.    .tBXtMMBMBY:        RIi  
   XIt                     ;IRBRXVRBY;   ;BBBMR=           ;VR  
  .RR                    ;RBt:     .+RB;  :BI:              VY; 
  +tX                   iBt           =BX                   itY 
  Yt=                  ;Bi             :Bt                  :XR 
  RX:                  RX               =B:                  RX.
  RR                  :B:                Ri                  YX:
  RR                  ;B                 YY                  YY;
  RR                  :B;                Ri                  YX:
  RX:                  RX               +B:                  RX.
  YI;                  +Ri             :Bt                  :XR 
  +tX              .i:  iBI           iBX                   itY 
  .RR            ;VBBB.  ;RBt:     :+RR+                    VY; 
   XIt        .tBMMMRBB;   ;tRBVXVBRY;                     ;VR  
   :RR.     ;RBMMBVBB;;RR;     .::.                        RIi  
    IIR  .tBMMMBMMB;RMX:                                  tIR   
     RII BMMBMMBiBMB;:+Vi:                               ;RR:   
     :RV;:BMBXBMB;;VBY.                                 :RX+    
      ;RV+:BMB;RBMY  ;t;                               ;RXt     
       ;RXt.RMB;:tBB=                                 ;RVi      
        :RYR.;BBY. :+t;                              IXR;       
          XXR+ ;RBY:                               ;RYR:        
           ;RYR; .;Yi:                           :XXVt          
             +VXV=                             ;YVVt.           
               +VXVI;                       ;tVXVt.             
                 ;tVXXYi;.              ;+IXXVY;                
                    ;tIVVXXYti=====iiIXXVVYt;                   
                        :;iitItttttItt+;:
  '';
}
