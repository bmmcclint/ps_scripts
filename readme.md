This repo contains various PowerShell Scripts in varying stages of completion.

slack_themer and theme are currently W.I.P.s. Curremtly designed to work on 
  Windows machines but will be branched to cross-platform support.

  The short term goal is to have a database of themes allowing users of Slack's 
  desktop application to change the color scheme of either the sidebar or the 
  main interface. This script will also automatically detect if there has been 
  a crash or update to Slack and will handle each differently.
  -If a crash has been experienced the program will be restarted immediately.
  -If Slack has updated, ssb-interop.js will be checked if it contains some
    custom css theme and will add it to it automatically, refreshing Slack's 
    interface afterwards.

  The long term goal is to have a web based theming site setup allowing users 
    to create custom themes on the fly and apply theme to their respective 
    desktop apps.

-------------------------------------------------------------------------------

toggle_touch Was designed to detect whether the touch screen was enabled or 
  disabled utilizing Windows Device Console (devcon).

-------------------------------------------------------------------------------

genericToggle is a reincarnation of toggle_touch deployed in an academic setting
  to support introductory computer science courses prevent touch misclicks for 
  teacher or students while debugging code. This tool automatically elevates 
  itself to administrator to facilitate the modification of device status.  
