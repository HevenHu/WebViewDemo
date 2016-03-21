//
//  NewsViewController.h
//  WebViewDemo
//
//  Created by Heven on 16/3/21.
//  Copyright © 2016年 Heven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSDictionary *newsInfo;
@property NSInteger newsIndex;

@end
