//
//  YouTubeViewController.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"

@interface YouTubeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    BOOL isSearching;
    BOOL isYoutubeFirstTime;
    AFHTTPRequestOperationManager *manager;
}
@property(nonatomic,strong) NSMutableArray *youtubeArray;
@property(nonatomic,strong) IBOutlet UITableView *tableView;
@end
