//
//  NoteListViewController.m
//  SecretNoteApp
//


#import "NoteListViewController.h"
#import "NoteView.h"
#import "CreateNoteViewController.h"
#import "Note+CoreDataProperties.h"
@interface NoteListViewController ()
{
   UITableView *notesTableView;
   NSMutableArray* filtered ;
   BOOL filterring ;
   NSMutableArray* noteArray;
}

@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    filterring = false;
    [self setUpNavBar];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView ];
    [self setUpSearchController];
}
-(void)setUpNavBar{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    [self.navigationItem setLargeTitleDisplayMode:UINavigationItemLargeTitleDisplayModeAutomatic] ;
    self.navigationItem.title = @"Notes";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"➕"
                                   style: UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(presentView)];
    self.navigationItem.rightBarButtonItem = addButton;
    addButton = nil;
    self.navigationItem.hidesBackButton = true;
    
}

-(void)setUpTableView{
    notesTableView = [[UITableView alloc] init];
    notesTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:notesTableView ];
    [notesTableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [notesTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [notesTableView.trailingAnchor constraintEqualToAnchor :self.view.trailingAnchor].active = YES;
    [notesTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [notesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    notesTableView.dataSource = self;
    notesTableView.delegate = self;
}

-(void)setUpSearchController{
    UISearchController* search = [[UISearchController alloc] initWithSearchResultsController:nil];
    search.searchResultsUpdater = self;
    search.obscuresBackgroundDuringPresentation = NO;
    search.searchBar.placeholder = @"Search Notes";
    self.navigationItem.searchController = search;
    self.definesPresentationContext = YES;
    search = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesSearchBarWhenScrolling = false;
    NoteView * headerView = [NoteView new];
    noteArray = [[NSMutableArray alloc] initWithArray:[headerView getNotes]] ;
    headerView = nil;
    [notesTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationItem.hidesSearchBarWhenScrolling = true;
}

-(void)presentView{
    CreateNoteViewController *createNoteVC = [[CreateNoteViewController alloc] initWithNibName:nil bundle:nil];
    createNoteVC.isNewNote = YES;
    [self.navigationController pushViewController:createNoteVC animated:YES ];
    createNoteVC = nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return filterring? filtered.count : noteArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell ;
    
    if (cell == nil)
    {
       cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Note *model = filterring ? filtered[indexPath.row] : noteArray[indexPath.row];
    cell.textLabel.text = model.title;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *result = [formatter stringFromDate:model.creationDate];
    cell.detailTextLabel.text = result ;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateNoteViewController *createNoteVC = [[CreateNoteViewController alloc] initWithNibName:nil bundle:nil];
    createNoteVC.isNewNote = NO;
    createNoteVC.note =  filterring ? filtered[indexPath.row] : noteArray[indexPath.row];
    [self.navigationController pushViewController:createNoteVC animated:YES ];
    createNoteVC = nil;
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __block Note* noteObj = noteArray[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        if( [self deleteNote:noteObj onRow:indexPath.row])
        {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }];
    
    return @[deleteAction];
}
-(BOOL)deleteNote:(Note*)note onRow:(NSInteger)row{
     NoteView *headerView = [NoteView new];
    if( [headerView deleteNote:note])
    {
        [noteArray removeObjectAtIndex:row];
        headerView = nil;
        return YES;
    }
    headerView = nil;
    return NO;
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString* searchString = searchController.searchBar.text;
    if([ searchString length] > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[cd] %@",searchString];
        NSArray* tempArr = [self->noteArray filteredArrayUsingPredicate:predicate];
        filtered = [NSMutableArray arrayWithArray:tempArr];
        filterring = true;
            }
            else {
                filterring = false;
                [filtered removeAllObjects];
            }
    [notesTableView reloadData];
}

-(void)dealloc{
    noteArray = nil;
    notesTableView = nil;
}
@end
