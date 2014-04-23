//
//  ViewController.h
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
