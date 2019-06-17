//
//  TabBarController.m
//  ExperimentWeek
//
//  Created by jojo Li on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "TabBarController.h"
#import "imageChangeSize.h"
@interface TabBarController ()
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    UIImage *image0 = [UIImage imageNamed:@"news-1.png"];
    UIImage *image1 = [UIImage imageNamed:@"news.png"];
    item0.image = [[imageChangeSize scaleToSize: image0 size: CGSizeMake(30.0f, 30.0f)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage = [[imageChangeSize scaleToSize: image1 size: CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.title = @"新闻";
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    image0 = [UIImage imageNamed:@"picture-1.png"];
    image1 = [UIImage imageNamed:@"picture.png"];
    item1.image = [[imageChangeSize scaleToSize: image0 size: CGSizeMake(30.0f, 30.0f)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[imageChangeSize scaleToSize: image1 size: CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.title = @"图片";
    
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
    image0 = [UIImage imageNamed:@"settings-1.png"];
    image1 = [UIImage imageNamed:@"settings.png"];
    item2.image = [[imageChangeSize scaleToSize: image0 size: CGSizeMake(30.0f, 30.0f)]
     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[imageChangeSize scaleToSize: image1 size: CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.title = @"我的";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
