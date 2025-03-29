# manage user rules
# NOTE: there can only be 1 (one) `adguard_user_rules` resource
# specifying multiple resources will result in errors
resource "adguard_user_rules" "rules" {
  rules = [
    "# Paramount Plus",
    "@@||paramountplus.com^$important",
    "@@||vaicore.site^$important",
    "@@||tags.tiqcdn.com^$important",
    "@@||paramountplus.com.data.adobedc.net^$important",
    "# MyFitnessPal",
    "@@||split.io^$important",
    "@@||sb.scorecardresearch.com^$important",
    "@@||cbsinteractive.data.adobedc.net^$important",
    "@@||pagead2.googlesyndication.com^$important",
    "@@||87a6b28bc7823e67a5bb2a0a6728c702afcae78d.ipv4.cws.conviva.com^$important",
    "@@||87a6b28bc7823e67a5bb2a0a6728c702afcae78d.ipv6.cws.conviva.com^$important",
    "@@||87a6b28bc7823e67a5bb2a0a6728c702afcae78d.cws.conviva.com^$important",
    "@@||onprem-ipv4.cws.conviva.com^$important",
    "@@||udm.scorecardresearch.com^$important",
    "@@||conviva.com^$important",
    "@@||brightline.tv^$important",
    "@@||pubads.g.doubleclick.net^$important",
    "@@||collector.cdp.cnn.com^$important",
    "@@||smetrics.cnn.com^$important",
    "@@||cnn.com.102.122.2o7.net^$important",
    "@@||licensing.bitmovin.com^$important",
    "@@||sentry.io^$important",
    "@@||warnermediacdn.com^$important",
    "@@||get.activated.win^$client='Backup Server'",
    "@@||dearpersonco.store^$important",
    "@@||decagon.ai^$important",
    "@@||api.sidechat.lol^$important"
  ]
}
