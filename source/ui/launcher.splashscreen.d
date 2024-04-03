module zenxplasma.splashscreen;

import std.digest;
import std.stdio;
import core.thread;
import dlangui;

class Splash
{
    private Window window;
    private string appname;
    private string appversion;

    this()
    {
        window = Platform.instance.createWindow("Splash", null, WindowFlag.Borderless, 1024, 480);

        loadSplashData();
        createWindow();
    }

    private void loadSplashData()
    {
        appname = "Zenxplasma Launcher";
        appversion = "1.0.0";
    }

    private void createWindow()
    {
        window.mainWidget = parseML(q{
            VerticalLayout {
                layoutWidth: fill
                layoutHeight: fill
                VerticalLayout {
                    TextWidget {
                        text: "Zenxplasma - Launcher"
                        textColor: white
                        fontSize: 48pt
                        fontFace: "ubuntu"
                        id: headerText
                    }
                    TextWidget {
                        text: "Easily launch & update CryZENx projects"
                        textColor: white
                        fontSize: 24pt
                        fontFace: "ubuntu"
                        id: subheaderText
                    }
                    HorizontalLayout {
                        TextWidget {
                            text: "Loading..."
                            textColor: white
                            fontSize: 16pt
                            fontFace: "ubuntu"
                            id: loadingText
                        }
                        ImageWidget {
                            minWidth: 64pt
                            minHeight: 64pt
                            id: loadingImage
                        }
                        TextWidget {
                            text: "Copyright © 2024, Ferryry"
                            textColor: white
                            fontSize: 8pt
                            fontFace: "ubuntu"
                            id: copyrightText
                        }
                    }
                }
            }
        });

        /*window.mainWidget.childById("headerText").margins(Rect(32, 32, 0, 0));
        window.mainWidget.childById("subheaderText").margins(Rect(32, 0, 0, 0));
        window.mainWidget.childById("loadingText").margins(Rect(880, 260, 0, 0));
        window.mainWidget.childById("copyrightText").margins(Rect(8, 8, 0, 0));*/

        window.mainWidget.backgroundDrawable = drawableCache.get("background_splash.tiled");
        ImageWidget image = cast(ImageWidget) window.mainWidget.childById("loadingImage");
        image.drawable = drawableCache.get("background_splash_loading");
    }

    private void loadingAnimation()
    {
        import core.thread : Thread, dur;

        long sleepduration = 1000;

        TextWidget loading = cast(TextWidget) window.mainWidget.childById("loadingText");

        while (true)
        {
            loading.text = "Loading.";
            Thread.sleep(dur!("msecs")(sleepduration));
            loading.text = loading.text ~ to!dstring(".");
            Thread.sleep(dur!("msecs")(sleepduration));
            loading.text = loading.text ~ to!dstring(".");
            Thread.sleep(dur!("msecs")(sleepduration));
        }
    }

    public void show()
    {
        if (window !is null)
            window.show();

        auto thread = new Thread(&loadingAnimation).start();
    }

    public void destroy()
    {
        if (window.isActive())
            window.destroy();
    }
}
