# TVDemo
tableview cell的高度自动计算
 cell高度计算的历史

在iOS8之前，如果UITableViewCell的高度是动态的，如果想要显示正确的话，我们需要在下面这个UITableView的代理方法中，返回每一行的精确高度：

    - (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;

如果cell的控件很多，样式很复杂的话，在这里面我们就可能需要写很多代码去做一些复杂的计算，甚至可能导致滑动不流畅。
系统的cell自适应高度的使用方法

首先我们需要把cell上的控件自上而下加好约束

一定是自上而下添加约束

加好约束后，然后告诉tableView自己去适应高度就可以了。有两种写法：

    self.tableView.rowHeight= UITableViewAutomaticDimension;

    self.tableView.estimatedRowHeight=100;

或者直接代理方法:

    - (CGFloat)tableView:(UITableView*)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath  {

          return100;

    }

这个的意思就是告诉tableView，你需要自己适应高度，我不给你算啦哈哈哈。但是我们需要告诉它一个大概高度，例如上面的100，理论上这个是可以随便写的，并不影响显示结果，但是越接近真实高度越好。

效果如下:



正确使用之后的效果

其实section的header和footer也是可以自动适应的，对应的方法有：

    - (CGFloat)tableView:(UITableView*)tableView estimatedHeightForHeaderInSection:(NSInteger)section;

    - (CGFloat)tableView:(UITableView*)tableView estimatedHeightForFooterInSection:(NSInteger)section;

注意:若约束不是自上而下就会发生高度显示不对的问题:



约束不是自上而下或者约束错误
点击状态栏无法滚动到顶部

我们知道，如果界面中有UIScrollView的话，点击状态栏会让其滚动到顶部，就像这样：


点击状态栏回到顶部

解决这个问题的办法是去缓存cell的高度，代码如下：

    @property(nonatomic,strong)NSMutableDictionary*heightAtIndexPath;//缓存高度所用字典

    #pragma mark - UITableViewDelegate

    -(CGFloat)tableView:(UITableView*)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath  {

    NSNumber*height = [self.heightAtIndexPathobjectForKey:indexPath];

          if(height)      {

               returnheight.floatValue;   

          }else{

               return100;   

          } 

    }

    - (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath  {

           NSNumber*height = @(cell.frame.size.height);  

           [self.heightAtIndexPathsetObject:height forKey:indexPath];

      }

解释一下，就是用一个字典做容器，在cell将要显示的时候在字典中保存这行cell的高度。然后在调用estimatedHeightForRowAtIndexPath方法时，先去字典查看有没有缓存高度，有就返回，没有就返回一个大概高度。

缓存高度之后，在demo里面多试几次，发现点击状态栏已经可以精确滚动回顶部了,这段代码其实可以写在viewController的基类里面，这样写一遍就可以每个地方都能缓存cell的高度了。详见demo。这样就完美了！
