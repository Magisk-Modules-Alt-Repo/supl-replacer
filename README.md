# Magisk SUPL replacer

Magisk module to replace the SUPL (Secure User-Plane Location) provider in Android's gps.conf.

SUPL is used as part of the A-GPS (Assisted GPS) system to get a faster Time to First Fix. The problem is that Android's implementation automatically sends the IMSI (ID of the SIM card) to the SUPL provider for no apparent reason. And because google is the default provider it's a big breach of privacy. Read more about it here : <https://blog.wirelessmoves.com/2014/08/supl-reveals-my-identity-and-location-to-google.html>.

So this module replaces the SUPL provider with one provided by Vodafone. It's self-hosted by the company in Germany. The company also should'nt be subject to US law because it doesn't operate there. And this is the best I can do because there aren't any privacy respecting providers and you can't self-host the SUPL data yourself.

The other active alternative providers with port 7275 accessible that I know of are:

- Sony Mobile: `supl.sonyericsson.com`
- Qianxun SI (China based): `supl.qxwz.com`

This module also replaces the NTP server specified in the same configuration file with `pool.ntp.org` which when resolved return the IP of the closest NTP server.

Some reading material on the subject:

<https://www.kuketz-blog.de/android-imsi-leaking-bei-gps-positionsbestimmung/>
<https://t.me/s/NoGoolag?q=%23GPS>
<https://www.reddit.com/r/degoogle/comments/cldohl/how_to_degoogle_lineageos_in_2019/>
