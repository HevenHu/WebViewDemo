//
//  NewsViewController.m
//  WebViewDemo
//
//  Created by Heven on 16/3/21.
//  Copyright © 2016年 Heven. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self showInWebView:nil];
}


- (void)showInWebView:(NSURL *)baseURL
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"NewsDetail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:baseURL];
}

- (NSString *)touchBody
{
    NSString *time = [self timeShi:[self.newsInfo objectForKey:@"dateline"] andGe:@"yyyy-MM-dd HH:mm:ss"];
    time = [self compareCurrentTime:time];
    
    NSMutableString *body = [NSMutableString string];
    
    [body appendFormat:@"<head><style>img{width:%fpx !important;text-align:center;margin-bottom:15px;margin-top:10px;display:block}</style></head>", self.view.frame.size.width-30];
    [body appendFormat:@"<head><style>video{width:%fpx !important;text-align:center;margin-bottom:15px;margin-top:10px;display:block}</style></head>", self.view.frame.size.width-30];
    [body appendFormat:@"<style type=\"text/css\"> body{text-align:left;text-indent:2em;margin:15px;font-size: 18;line-height:1.5;font-family:STHeitiSC-Light;color:#000000}</style>"];
    
    [body appendFormat:@"<div class=\"title\">%@</div>", [self.newsInfo objectForKey:@"title"]];
    [body appendFormat:@"<div class=\"media\">%@</div>", [self.newsInfo objectForKey:@"author"]];
    [body appendFormat:@"<div class=\"time\">%@</div>", time];
    
    
    if ([self.newsInfo objectForKey:@"content"]) {
        [body appendString:[self.newsInfo objectForKey:@"content"]];
    }
    return body;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"load failed...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"load finished...");
}


- (NSString *)timeShi:(NSString *)tim andGe:(NSString *)geS{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:geS];
    NSInteger time = [tim intValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (NSString *) compareCurrentTime:(NSString*)time
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:time];
    NSLog(@"%@", date);
    
    NSTimeInterval late = [date timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSString *timeString = @"";
    
    NSTimeInterval cha = now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1 && cha/86400<=7)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];
    }
    if (cha/86400>7)
    {
        timeString = [NSString stringWithFormat:@"%@",time];
    }
    return  timeString;
}

@end
