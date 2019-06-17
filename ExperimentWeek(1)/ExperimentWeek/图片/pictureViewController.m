//
//  pictureViewController.m
//  ExperimentWeek
//
//  Created by YU on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "pictureViewController.h"
#import "CollectionWaterfallLayout/CollectionWaterfallLayout.h"
#import "DataListObject.h"
#define StatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NavigationBarHeight (self.navigationController.navigationBar.frame.size.height)
#define TabBarHeight (self.tabBarController.tabBar.frame.size.height)

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

static NSString *const kCollectionViewItemReusableID = @"kCollectionViewItemReusableID";
static NSString *const kCollectionViewHeaderReusableID = @"kCollectionViewHeaderReusableID";


@interface pictureViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionWaterfallLayoutProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CollectionWaterfallLayout *waterfallLayout;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation pictureViewController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupDataList];
    [self setupRightButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (void)setupDataList
{
    
    //解析JSON
    NSInteger count = 20;//请求图片总数
    NSURL * url = [NSURL URLWithString:[@"https://image.baidu.com/wisebrowse/data?tag1=摄影&tag2=全部&pn=0&rn=20" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response,
                                               NSData * _Nullable data,
                                               NSError * _Nullable connectionError) {
                               NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                               /*NSMutableString * s = dict[@"imgs"];
                                [s replaceCharactersInRange:NSMakeRange(0, 1) withString:@"["];
                                [s replaceCharactersInRange:NSMakeRange(s.length - 1, 1) withString:@"]"];*/
                               //NSLog(@"%@",dict);
                               //----------处理图片到datalist中
                               _dataList = [NSMutableArray array];
                               
                               //数据源的个数；
                               NSInteger dataCount = count;
                               //逐一向datalist中添加对象
                               for(NSInteger i=0; i<dataCount; i++){
                                   //向网络请求一张图片
                                   
                                   DataListObject * obj =
                                   [DataListObject
                                    buildWithtitle:dict[@"imgs"][i][@"title"]
                                    Fromurl:dict[@"imgs"][i][@"fromurl"]
                                    Content_sign:dict[@"imgs"][i][@"content_sign"]
                                    Obj_url:dict[@"imgs"][i][@"obj_url"]
                                    Small_url:dict[@"imgs"][i][@"small_url"]
                                    Mid_url:dict[@"imgs"][i][@"mid_url"]
                                    AlbumNum:[dict[@"imgs"][i][@"albumNum"] integerValue]
                                    DataId:[dict[@"imgs"][i][@"dataId"] integerValue]
                                    Image_width:[dict[@"imgs"][i][@"image_width"] integerValue]
                                    Image_height:[dict[@"imgs"][i][@"image_height"] integerValue]
                                    Mid_height:[dict[@"imgs"][i][@"mid_height"]integerValue]
                                    Mid_width:[dict[@"imgs"][i][@"midwidth"]integerValue]
                                    Set_id:[dict[@"imgs"][i][@"set_id"]integerValue]
                                    Small_height:[dict[@"imgs"][i][@"small_height"]integerValue]
                                    Small_width:[dict[@"imgs"][i][@"small_width"]integerValue]
                                    ];
                                   //图片高度设置
                                   
                                   //将一个图片的高度值添加到数据源中；
                                   [_dataList addObject:obj];
                               }
                               //-----------
                           }];
    //
    
    
    
}
//设置右上角按钮
- (void)setupRightButton
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self action:@selector(buttonClick)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, nil];
}

- (void)buttonClick
{
    [self setupDataList];
    [self.collectionView reloadData];
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        //初始化
        _waterfallLayout = [[CollectionWaterfallLayout alloc] init];
        //设置代理
        _waterfallLayout.delegate = self;
        //设置每一行列数
        _waterfallLayout.columns = 2;
        //设置列边距
        _waterfallLayout.columnSpacing = 10;
        //设置距离上下左右的间隙（边距）
        _waterfallLayout.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-StatusBarHeight-NavigationBarHeight) collectionViewLayout:_waterfallLayout];
        //设置collectionView的代理与数据源
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //设置collectionView的背景颜色
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewItemReusableID];
        UINib *headerViewNib = [UINib nibWithNibName:@"WFHeaderView" bundle:nil];
        [_collectionView registerNib:headerViewNib forSupplementaryViewOfKind:kSupplementaryViewKindHeader withReuseIdentifier:kCollectionViewHeaderReusableID];
    }
    
    
    return _collectionView;
}

//数据源
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //
    if(section == 0){
        //返回数据源中数据的总条数
        return _dataList.count;
    }
    return 0;
}

//设置背景颜色
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"当前处理的cell是第%d个",indexPath.item);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewItemReusableID forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UICollectionViewCell alloc] init];
    }
    
    //以下为生成虚拟图片颜色的代码
//    CGFloat red = arc4random()%256/255.0;
//    CGFloat green = arc4random()%256/255.0;
//    CGFloat blue = arc4random()%256/255.0;
    
    
    NSURL * imageURL = [NSURL URLWithString:[_dataList[indexPath.item] small_url]];
    UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    NSLog(@"当前处理的cell是第%ld个,试图访问",(long)indexPath.item);
    UIImageView *imageV=[[UIImageView alloc]init];
    imageV.image = img ;
    
    //cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    cell.backgroundView = imageV;
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:kSupplementaryViewKindHeader]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionViewHeaderReusableID forIndexPath:indexPath];
        //返回顶部栏图片
        return headerView;
    }
    return nil;
}

#pragma mark - CollectionWaterfallLayoutProtocol
- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //计算行数
    NSInteger row = indexPath.row;
    //获取第row行的单元高度
    
    CGFloat cellHeight = [_dataList[row] small_height];
    return cellHeight;
}

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0){
        //返回300时，预留顶部栏图片高度
        //return 300;
        //返回0时，屏蔽顶部栏图片
        return 0;
    }
    return 0;
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
