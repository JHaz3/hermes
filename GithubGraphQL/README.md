#  Peek challenge


I decided to go over with SwiftUI since it allowed me to create the UI easier and faster than UIKit giving me time to
add unit test and UITests. SwiftUI works great with MVVM so that is something else i thought when choosing it.

Finally I like how responsive and reactive SwiftUI is with MVVM.

With more time I could add.

1. More UI tests to check other flows like searching words that doesn't exists.
2. A feature to open the github repo from the URL
3. A feature to search when writing instead of pressing the return keyboard button
4. A detailed screen of the repo displaying more relevant information.
5. Improved the design.

The only third framework added was the URLImage which gives me the ability to load the images of the repo's owner. 
Please noticed that i followed the Adapter design patter on that URLImage framework called `SwiftUIImage` to avoid spreading the dependency through other files.

For UITesting i followed a nice pattern called Robots which give us the flexibility to have a Robot per App screen
then you can reuse the robots where needed and where multiple screens are displayed/reused. Also the Robots pattern
gives the flexibility of encapsulating all the logic related to how an user interacts with the screen and what elements
needs to be validated. Be aware that you can have scenarios when multiples tests verify some texts or buttons in the screens
having those checks verifications in the Robot file allows you to just call those functions from different parts.

 
