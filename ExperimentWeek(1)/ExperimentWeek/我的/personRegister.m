//
//  personRegister.m
//  ExperimentWeek
//
//  Created by jojo Li on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "personRegister.h"
#import "Sqlite3Manager.h"

@interface personRegister ()
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *idText;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sex;
@property (strong, nonatomic) IBOutlet UIButton *registerBut;
@property (strong, nonatomic) IBOutlet UIButton *callOff;
@end

@implementation personRegister

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerBut:(id)sender {
    NSString *name = _nameText.text;
    NSString *ID = _idText.text;
    NSString *sex = [NSString stringWithFormat:@"%ld", (long)[_sex selectedSegmentIndex]];
//    Sqlite3Manager *s = [[Sqlite3Manager alloc] init];
//    NSLog(@"%@",[s getAll]);
    if(![name  isEqual: @""] && ![ID  isEqual: @""]){
        Sqlite3Manager *s = [[Sqlite3Manager alloc] init];
        [s addWithName: name Number: ID Sex: sex];
    }
}

- (IBAction)callOff:(id)sender {
    _nameText.text = nil;
    _idText.text = nil;
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
