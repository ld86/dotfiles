import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Hooks.ManageHelpers
import System.IO
import Graphics.X11.ExtraTypes.XF86

main = do
        xmproc <- spawnPipe "/home/ld86/.local/bin/xmobar"
        xmonad $ desktopConfig
            { modMask = myModMask , borderWidth = 1
            , logHook = dynamicLogWithPP $ xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle  = xmobarColor "green" "" . shorten 50
                    }
            } `additionalKeysP` myKeys

myModMask = mod4Mask -- Use Super instead of Alt
myKeys =  [ ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")    
          , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")    
          ]
