# Magisk SUPL replacer

Magisk module to replace the SUPL (Secure User-Plane Location) provider in Android's gps.conf.

## Background

SUPL is used as part of the A-GPS (Assisted GPS) system to get a faster Time to First Fix. The problem is that Android's implementation automatically sends the IMSI (ID of the SIM card) to the SUPL provider for no apparent reason. And because Google is the default provider it's a big breach of privacy.

This module replaces the SUPL provider with one from Orange. It's not perfect, the company isn't known for its privacy involvement, but it's not possible to self-host a SUPL server and I haven't found a better provider.  
At least the service is self-hosted by the company in France and Orange also shouldn't be subject to US law because they don't operate there.

The other active alternative providers with port 7275 accessible that I know of are:

- Sony Mobile: `supl.sonyericsson.com`
- Qianxun SI (China based): `supl.qxwz.com`

Another solution would simply be to disable SUPL altogether by replacing `supl.google.com` with `localhost`, but then the Time to First Fix can increase a lot, going from a couple of seconds to a couple of minutes.

If you want to learn more about the subject here's some reading material:

- A series of blog posts from a telecom engineer on how he discovered that Android is "leaking" the IMSI to the SUPL provider: <https://blog.wirelessmoves.com/2014/08/supl-reveals-my-identity-and-location-to-google.html>
- A blog post by a German security researcher that has done an in-depth analysis on to replace the SUPL provider: <https://www.kuketz-blog.de/android-imsi-leaking-bei-gps-positionsbestimmung/>
- A post on the subreddit /r/degoogle describing other modification you can make to android in order to "degoogle it" more: <https://www.reddit.com/r/degoogle/comments/cldohl/how_to_degoogle_lineageos_in_2019/>

This module also replaces the NTP server specified in the same configuration file with `europe.pool.ntp.org` which when resolved returns the IP of the closest european NTP server.

## Installation

Simply download the latest build from the [Release](https://github.com/D3SOX/magisk-supl-replacer/releases) section and install it with Magisk Manager!

You can also flash it in a custom recovery like TWRP but using Magisk Manager is definitely recommended.

## Contributing

Contributions are welcome if you see any area of improvement!

## Acknowledgments

- John Wu for the creation of the wonderful tool that is Magisk.
- The persons that have done analysis and written the blog posts linked above.

## License

This project is released under the [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause). A copy of the license is available in this project folder.
