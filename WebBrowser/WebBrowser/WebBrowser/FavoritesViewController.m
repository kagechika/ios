//
//  FavoritesViewController.m
//  WebBrowser
//
//  Created by okitokagechika on 2014/04/16.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController{
    NSMutableArray *favoriteList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //favoritesを初期化
    favoriteList = [[NSMutableArray alloc] init];
    
    //DBを参照して内容をfavoritesに入れる
    [self queryDB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//DBに登録されたお気に入りを参照
-(void)queryDB{
    //CoreDataの呼び出し準備
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //DBの参照結果を保持する
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Table名を指定
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyFavorites" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    //title昇順で並び替え
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //データ参照を実施
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
    }
    
    //参照結果をfavoriteListに格納
    NSArray *moArray = [fetchedResultsController fetchedObjects];
    for (int i=0; i<moArray.count; i++) {
        NSManagedObject *object = [moArray objectAtIndex:i];
        Favorites *f = [[Favorites alloc] init];
        f.title = [object valueForKey:@"title"];
        f.url = [object valueForKey:@"url"];
        
        [favoriteList addObject:f];
    }
}

//TableViewのセクション数を設定
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//TableViewのセル数を設定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [favoriteList count];
}

//各セルにタイトルをセット
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //セルのスタイル
    static NSString *CellIdentifier = @"Cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //セルにお気に入りサイトのタイトルを表示
    Favorites *f = [favoriteList objectAtIndex:[indexPath row]];
    cell.textLabel.text = f.title;
    
    return  cell;
}

//リスト中のお気に入りアイテムが選択されたとき
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //選択された項目のURL
    Favorites *f = [favoriteList objectAtIndex:[indexPath row]];
    
    NSString *selectedURL = f.url;
    
    //引数にURLを指定し、Delegate通知
    [self.delegate favoritesViewControllerDidSelect:self withURL:selectedURL];
}

//戻るボタンが押されたとき
-(IBAction)back:(id)sender{
    //delegateに通知
    [self.delegate favoritesViewControllerDidCancel:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
