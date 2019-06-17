//
//  SettingPageViewController.m
//  ExperimentWeek
//
//  Created by jojo Li on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "SettingPageViewController.h"
#import "Sqlite3Manager.h"
#import "personRegister.h"
#import "ContactViewController.h"
#import "imageChangeSize.h"

#import "MyTableCell.h"

@interface SettingPageViewController ()<UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic) IBOutlet UITabBarItem *settingsTabBar;
@property (strong, nonatomic) NSArray *settings;
@end

@implementation SettingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage *image3 = [UIImage imageNamed:@"settings-50.png"];
//    self.settingsTabBar.image  = [self scaleToSize: image3 size: CGSizeMake(30.0f, 30.0f)];
    
    self.settings = @[@"个人信息录入",@"二维码扫描",@"我的通讯录"];
    // 创建UItableView，style选择Grouped或Plain，这里我们以Grouped为例
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStyleGrouped];
    // 声明 tableView 的代理和数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    // 添加到 view 上
    [self.view addSubview:tableView];
    /* Sqlite3Manager* s = [[Sqlite3Manager alloc] init];
     [s test]; */
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settings count];
    //    if (section == 0) {
    //        return 2;
    //    }else {
    //        return 1;
    //    }
}

// 设置每个 Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建一个cellID，用于cell的重用
    NSString *cellID = @"cellID";
    // 从tableview的重用池里通过cellID取一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    // 设置 cell 的标题
    cell.textLabel.text = self.settings[indexPath.row];
    UIImage *image = nil;
    switch(indexPath.row){
        case 0:
            image = [UIImage imageNamed:@"person-50.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"scan-50.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"contact-50.png"];
            break;
        default:
            break;
    }
    image = [imageChangeSize scaleToSize: image size:CGSizeMake(30.0f, 30.0f)];
    cell.imageView.image = image;
    // 设置 cell 的副标题
    //    cell.detailTextLabel.text = self.contacts[indexPath.row][@"phoneNumber"];
    
    //小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
// 选中了 cell 时触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //页面跳转
    UIStoryboard *settingsStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    personRegister *Register = [settingsStoryBoard instantiateViewControllerWithIdentifier:@"personRegister"];
    ContactViewController *contact = [settingsStoryBoard instantiateViewControllerWithIdentifier:@"contact"];
    switch (indexPath.row) {
        case 0:
            //跳转事件
            [self.navigationController pushViewController:Register animated:YES];
            //            [self performSegueWithIdentifier:@"personRegister" sender:self];
            break;
        case 1:
            
            break;
        case 2:
            [self.navigationController pushViewController:contact animated:YES];
            break;
        default:
            break;
    }
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
