//
//  ViewController.h
//  WebViewDemo
//
//  Created by Heven on 16/3/21.
//  Copyright © 2016年 Heven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *newsList;
@property (strong, nonatomic) UIImageView *logoImageView;

@end
