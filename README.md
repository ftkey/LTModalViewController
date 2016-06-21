# LTModalViewController
LTModalViewController a easy way to display modal style controller

```
    @IBAction func onAlert(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(ModalViewController(rootController:rootVc ,contentSize:CGSizeMake(320, 200),radius:8, style:.Alert), animated: true, completion: nil)
        
    }
```
    
```
    @IBAction func onActionSheet(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(ModalViewController(rootController:rootVc ,contentSize:CGSizeMake(320, 200), style:.ActionSheet), animated: true, completion: nil)
        
    }
```

![DEMO](https://github.com/Ftkey/LTModalViewController/raw/master/Example/DEMO.gif)