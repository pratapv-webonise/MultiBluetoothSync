//
//  YouTubeViewController.m
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import "YouTubeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "YouTubeCell.h"
#import "UIImageView+AFNetworking.h"
#import "VideoViewController.h"

@interface YouTubeViewController ()

@end

@implementation YouTubeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
          }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

    self.searchDisplayController.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.searchDisplayController setDisplaysSearchBarInNavigationBar:NO];
    manager = [AFHTTPRequestOperationManager manager];
    [self searchYoutubeVideosForTerm:@"ios"];
    isYoutubeFirstTime = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma loadData

-(void)searchYoutubeVideosForTerm:(NSString*)term
{
    if (isSearching) {
        [manager.operationQueue cancelAllOperations];
    }
    _youtubeArray = [[NSMutableArray alloc]init];
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?q=%@&max-results=20&alt=json", term];
    
    [manager GET:searchCall parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       _youtubeArray = responseObject[@"feed"][@"entry"];
        if(isSearching==NO){
            [_tableView reloadData];
        }
        else{
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark
#pragma tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _youtubeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *tempDict = _youtubeArray[indexPath.row];
    YouTubeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[YouTubeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.videoTitleLabel.text = tempDict[@"title"][@"$t"];
    [cell.videoImageView setImageWithURL:[NSURL URLWithString:[[tempDict[@"media$group"][@"media$thumbnail"]objectAtIndex:0]valueForKey:@"url"]]];
    NSString *s = tempDict[@"media$group"][@"yt$duration"][@"seconds"];
    float t =  [s floatValue] /60;
    cell.playTimeLabel.text = [NSString stringWithFormat:@"%.2f",t];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 123;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoViewController *video = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    video.dictionary = _youtubeArray[indexPath.row];
    [self.navigationController pushViewController:video animated:YES];
}

#pragma mark
#pragma Search delagete delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchYoutubeVideosForTerm:searchText];
}

@end
