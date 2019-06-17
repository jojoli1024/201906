//
//  ContactViewController.m
//  ExperimentWeek
//
//  Created by jojo Li on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "ContactViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface ContactViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) NSArray *contacts;
@property(strong, nonatomic) UITableView *tableView;
@end

@implementation ContactViewController

// 获取通讯录信息，自定义方法
- (void)fetchAddressBookOnIOS9AndLater {
    // 创建 CNContactStore 对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 首次访问需用户授权
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        // 首次访问通讯录
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error){
                if (granted) {
                    // 允许
                    NSLog(@"已授权访问通讯录");
                    //                    NSArray *contacts = [self fetchContactWithContactStore:contactStore];   // 访问通讯录
                    self.contacts = [self fetchContactWithContactStore:contactStore];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 主线程 更新 UI
                        [self.tableView reloadData];
                        NSLog(@"contacts:%@", self.contacts);
                    });
                } else {
                    // 拒绝
                    NSLog(@"拒绝访问通讯录");
                    // todo：跳转到设置中添加允许
                }
            } else {
                NSLog(@"发生错误!");
            }
        }];
    } else {
        // 非首次访问通讯录
        //        NSArray *contacts = [self fetchContactWithContactStore:contactStore];   // 访问通讯录
        self.contacts = [self fetchContactWithContactStore:contactStore];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程 更新 UI
            [self.tableView reloadData];
            NSLog(@"contacts:%@", self.contacts);
        });
    }
}

// 访问通讯录，自定义方法
- (NSMutableArray *)fetchContactWithContactStore:(CNContactStore *)contactStore {
    // 判断访问权限
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        
        // 有权限访问
        NSError *error = nil;
        // 创建数组，必须遵守 CNKeyDescriptor 协议，放入相应的字符串常量来获取对应的联系人信息
        NSArray <id<CNKeyDescriptor>> *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey];
        // 获取通讯录数组
        NSArray<CNContact*> *arr = [contactStore unifiedContactsMatchingPredicate:nil keysToFetch:keysToFetch error:&error];
        if (!error) {
            
            NSMutableArray *contacts = [NSMutableArray array];
            for (int i = 0; i < arr.count; i++) {
                
                CNContact *contact = arr[i];
                NSString *givenName = contact.givenName;
                NSString *familyName = contact.familyName;
                NSString *phoneNumber = ((CNPhoneNumber *)(contact.phoneNumbers.lastObject.value)).stringValue;
                NSString *name = [familyName stringByAppendingString: givenName];
                if( name != nil && phoneNumber){
                    [contacts addObject:@{@"name": name, @"phoneNumber":phoneNumber}];
                }
            }
            return contacts;
        } else {
            return nil;
        }
        
    } else {
        // 无权限访问
        NSLog(@"无权限访问通讯录");
        
        return nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.contacts = [[NSArray alloc] init];
    [self fetchAddressBookOnIOS9AndLater];
    
    // 创建UItableView，style选择Grouped或Plain，这里我们以Grouped为例
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStyleGrouped];
    // 声明 tableView 的代理和数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 添加到 view 上
    [self.view addSubview:self.tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)[self.contacts count]);
    return [self.contacts count];
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
    cell.textLabel.text = self.contacts[indexPath.row][@"name"];
    // 设置 cell 的副标题
    cell.detailTextLabel.text = self.contacts[indexPath.row][@"phoneNumber"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// 选中了 cell 时触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获得电话
    NSString *telephoneNumber= self.contacts[indexPath.row][@"phoneNumber"];
    telephoneNumber = [telephoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    NSLog(@"%@", str);
    // 弹出提示框，拨打电话
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
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
