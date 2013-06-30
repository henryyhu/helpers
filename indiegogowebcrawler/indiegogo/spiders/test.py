from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.selector import HtmlXPathSelector
from indiegogo.items import IndiegogoItem

class MySpider(CrawlSpider):
    name = "indiegogo"
    allowed_domains = ["indiegogo.com"]
    start_urls = ["http://www.indiegogo.com/projects"]

    rules = (Rule(SgmlLinkExtractor(allow=['pg_num=\d'], restrict_xpaths=('//a')),
                  callback='parse_items', follow= True, ),
    )

    def parse_items(self, response):
        hxs = HtmlXPathSelector(response)
        deals = hxs.select("/html/body/div[5]/div/div/section/ul[2]/li/div[3]")
        items = []
        for deal in deals:
            item = IndiegogoItem()
            item ["title"] = deal.select("a/text()").extract()
            item ["link"] = deal.select("a/@href").extract()
            items.append(item)
        return(items)
