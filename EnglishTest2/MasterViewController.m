//
//  MasterViewController.m
//  EnglishTest2
//
//  Created by 中山　貴仁 on 2014/11/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
     _objects=[NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_objects removeAllObjects];
    NSFileManager *FManager=[NSFileManager defaultManager];
    NSURL *docDURL=[FManager URLForDirectory:NSDocumentDirectory
                                    inDomain:NSUserDomainMask
                           appropriateForURL:nil
                                      create:NO
                                       error:nil];
    NSArray *file=[FManager contentsOfDirectoryAtURL:docDURL
                          includingPropertiesForKeys:@[NSURLContentAccessDateKey]
                                             options:0
                                               error:nil];
    [_objects addObjectsFromArray:file];
    [_objects sortUsingComparator:^NSComparisonResult(id obj1,id obj2){
        NSDate *date1,*date2;
        [obj1 getResourceValue:&date1 forKey:NSURLContentModificationDateKey error:nil];
        [obj2 getResourceValue:&date2 forKey:NSURLContentModificationDateKey error:nil];
        return [date2 compare:date1];
    }];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        //self.objects = [[NSMutableArray alloc] init];
        
        _objects = [NSMutableArray array];
    }
    
    NSDictionary *dic=@{ @"title": @"題名",@"body":@"内容"};
    NSFileManager *FManager=[NSFileManager defaultManager];
    NSURL *docDURL=[FManager URLForDirectory:NSDocumentDirectory
                                    inDomain:NSUserDomainMask
                           appropriateForURL:nil
                                      create:NO
                                       error:nil];
    NSString *fileName=[[[NSUUID UUID] UUIDString] stringByAppendingPathExtension:@"txt"];
    NSURL *FURL=[docDURL URLByAppendingPathComponent:fileName];
    if([dic writeToURL:FURL atomically:YES]){//dicをFURLへ書き込み
        //書き込みに成功したならテーブルに追加する
   [_objects insertObject:FURL atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       // NSDate *object = self.objects[indexPath.row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *str1 = [defaults stringForKey:@"tv1"];
        //NSString *object1 = str1;
        [[segue destinationViewController] setDetailItem:str1];
        NSString *str2 = [defaults stringForKey:@"tv2"];
        //NSString *object2 = str2;
        [[segue destinationViewController] setDetailItem:str2];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = self.objects[indexPath.row];
    NSURL *FURL = _objects[indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:FURL];
    cell.textLabel.text = dic[@"title"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }*/

if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSURL *FURL=_objects[indexPath.row];//ファイルURLを取得
    NSFileManager *FManager=[NSFileManager defaultManager];
    if([FManager removeItemAtURL:FURL error:nil]){  //ファイルを削除
        //成功したらテーブルも削除
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
}

@end
