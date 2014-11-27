//
//  DetailViewController.h
//  EnglishTest2
//
//  Created by 中山　貴仁 on 2014/11/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITextViewDelegate>{
    
    
//    IBOutlet UITextView *tv1;
//    IBOutlet UITextView *tv2;
}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UITextView *tview1;
@property (strong, nonatomic) IBOutlet UITextView *tview2;



@end

