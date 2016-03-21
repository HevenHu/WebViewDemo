//
//  ViewController.m
//  WebViewDemo
//
//  Created by Heven on 16/3/21.
//  Copyright © 2016年 Heven. All rights reserved.
//

#import "ViewController.h"
#import "NewsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationController.navigationItem.titleView = self.logoImageView;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsList" ofType:@"plist"];
    self.newsList = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
//    NSLog(@"newsList = %@", self.newsList);
    
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:0 options:options];
    
    NewsViewController *startViewController = [self viewControllerAtIndex:0];
    self.title = [startViewController.newsInfo objectForKey:@"author"];
    
    [self.pageViewController setViewControllers:@[startViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    [self addChildViewController:self.pageViewController];
    
    [self.view insertSubview:self.pageViewController.view atIndex:0];
    [self.pageViewController.view setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.pageViewController didMoveToParentViewController:self];

}



- (NewsViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.newsList count] == 0) || (index >= [self.newsList count])) {
        return nil;
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewsViewController *newsViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    newsViewController.newsIndex = index;
    newsViewController.newsInfo = [self.newsList objectAtIndex:index];
    
    return newsViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((NewsViewController *)viewController).newsIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index -= 1;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((NewsViewController *)viewController).newsIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index += 1;
    if (index == [self.newsList count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"transition...");
    if(completed && finished) {
        NewsViewController *newsViewController = (NewsViewController*) [pageViewController.viewControllers lastObject];
        
        self.title = [newsViewController.newsInfo objectForKey:@"author"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
