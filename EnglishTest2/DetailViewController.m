//
//  DetailViewController.m
//  EnglishTest2
//
//  Created by 中山　貴仁 on 2014/11/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str1 = [defaults stringForKey:@"tv1"];
    NSString *str2 = [defaults stringForKey:@"tv2"];
    _tview1.text = str1;
    _tview2.text = str2;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)saveData
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.tview1.text forKey:@"tv1"];
    [defaults setObject:self.tview2.text forKey:@"tv2"];
    

}*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // ここにtextデータの処理
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.tview1.text forKey:@"tv1"];
    [defaults setObject:self.tview2.text forKey:@"tv2"];

    
    // キーボードを閉じる
    [self.tview1 resignFirstResponder];
    [self.tview2 resignFirstResponder];
}



/*-(void)textViewDidEndEditing:(UITextView *)tview1
{
    [self saveData];
    }*/

@end
