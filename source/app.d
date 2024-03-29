module main;

import dlangui;
import zenxplasma.splashscreen;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args)
{
    embeddedResourceList.addResources(embedResourcesFromList!("resources.list")());
    
    auto splashscreen = new Splash();
    splashscreen.show();

    return Platform.instance.enterMessageLoop();
}