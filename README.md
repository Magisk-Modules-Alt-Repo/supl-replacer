# Magisk SUPL replacer

Magisk module to replace the SUPL (Secure User-Plane Location) provider in Android's gps.conf.

SUPL is used as part of the A-GPS (Assisted GPS) system to get a faster Time to First Fix. The problem is that Android's implementation automatically sends the IMSI (ID of the SIM card) to the SUPL provider for no apparent reason. And because google is the default provider it's a big breach of privacy. Read more about it here : <https://blog.wirelessmoves.com/2014/08/supl-reveals-my-identity-and-location-to-google.html>.
