//
//  ViewController.m
//  CodeChallenge
//
//  Created by Mohammed Abdelkarym on 4/22/14.
//  Copyright (c) 2014 Mohammed Abdelkarym. All rights reserved.
//

#import "ViewController.h"
#import "Manager.h"
#import "Actor.h"

@interface ViewController ()<managerDelegate>
{
    BOOL serarching;
}
@property (strong, nonatomic)Manager *manger;
@property (strong, nonatomic)NSArray *searchResultArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
    serarching=false;
    self.manger=[[Manager alloc]init];
    self.manger.delegtae=self;
    [self.manger fetchMovieDetailsWithUrl:@"http://www.nousguideinc.com/43254235dsffds34f/8y39485y.json"];
}

#pragma mark -
#pragma mark manager repsonse handlers
-(void)movieDetailDownloaded{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=false;
    [self.tableView reloadData];    
}

-(void)actorImageDownloadedWithIndex:(int)index{
    NSIndexPath *inddexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:inddexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header=[NSString stringWithFormat:@"%@    %@",self.manger.movieTitle,self.manger.year];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(serarching){return self.searchResultArray.count;}
    
    return self.manger.cast.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Actor *actor;
    
    if(serarching)
        actor=self.searchResultArray[indexPath.row];
    else
        actor=self.manger.cast[indexPath.row];
    
    cell.textLabel.text=actor.titleText;
    cell.detailTextLabel.text=actor.detailText;

    cell.imageView.image=actor.image;
    return cell;
}

#pragma mark -
#pragma mark TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([MFMailComposeViewController canSendMail]) {
        Actor *actor;
        
        if(serarching)
            actor=self.searchResultArray[indexPath.row];
        else
            actor=self.manger.cast[indexPath.row];
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:actor.titleText];
        [mailViewController setMessageBody:actor.detailText isHTML:NO];
        
        [self presentViewController:mailViewController animated:YES completion:NULL];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark Search bar life cycle
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    serarching=YES;
    self.searchResultArray=[[NSMutableArray alloc]init];
    
    //Filter process
    NSString* filter = @"%K CONTAINS[cd] %@ || %K CONTAINS[cd] %@";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"self.titleText", searchText,@"self.detailText",searchText];

    self.searchResultArray= [self.manger.cast filteredArrayUsingPredicate:predicate];
    
    if (searchText.length==0) {
        serarching=NO;
    }
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    //clean after searchign done
    serarching=NO;
    self.searchResultArray=NULL;
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

@end
