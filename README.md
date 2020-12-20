# Todo App

TodoApp is a reminder app written in Swift and by using MVVM design pattern and POP.
The app includes 2 screens; list and detail.

## List Screen

The screen where users' to do items are listed. Users can add new to do item by tapping + button at the top right corner and filling a title and detail.

Also user can delete your to do items by swiping the item you want to left and tapping 'Delete' button 

## Detail Screen

The screen where your to do item's details are listed. This screen also be used to create new to do items. 

- If you press + button in list screen, detail screen will appear with empty title and detail fields to fill. Also trash button in top right corner will not be visible.
- If user get this screen by tapping a todo item, user will be able to edit your to do item. Also you can delete the item by pressing trash button at top right corner
- When editing is complete, you can add or update item by pressing done button. 
- Last 2 actions actions will automatically navigate user to updated list screen

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
