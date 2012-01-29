#/bin/bash
workingDir=`pwd`
JUIC_BIN=`dirname $0`
JUIC_GEN_HOME=`cd "$JUIC_BIN"/../;pwd`
#util function to capitilize a given string
capitalize_string(){
    strings="$@"
    first=${strings:0:1}
    left=${strings:1}
    First=`echo "$first" | tr a-z A-Z`
    echo "$First$left"
}
#util function to convert a string to lower cases.
to_lower(){
    echo "$@" | tr A-Z a-z
}
to_upper(){
    echo "$@" | tr a-z A-Z
}
#work out page name of action name (like action_name.xhtml)
split_action_name(){
    strings="$@"
    len=${#strings}
    idx=0
    page=""
    while [ "$idx" -lt "$len" ];do
        c=${strings:$idx:1}
        let "idx += 1"
        if [[ "$c" =~ [A-Z] ]];then
            page="$page"_"$c"
        else
            page="$page$c"
        fi
    done
    to_lower "$page"
}
#programme main entry to test if current direcotry is a working folder
if [ ! -d web ] && [ ! -d src ] && [ ! -f "build.xml" ]; then
    echo "$workingDir is not a working directory"
    exit 0
fi
#read in project name and create direcotry stucture
while true; do
echo -n "Enter the project name: "
read prj
if [ -d "web/ui/$prj" ]; then
    echo -n "$prj already exists, just use this one? (y/n)"
    read answer_to_prj
    if [ "$answer_to_prj" = "y" ]; then
        break
    fi
else
#create folder structure
    mkdir -p web/ui/"$prj"/{js,css,pages}
    echo "folder $prj $prj/js $prj/css and $prj/pages created"
    cp "$JUIC_GEN_HOME/style.css" web/ui/"$prj"/css/"${prj}_style.css"
    echo "${prj}_style.css file created under web/ui/$prj/css"
    break
fi
done
#create js files
JS_DEST="web/ui/$prj/js"
while true; do
    echo -n "Enter action name: "
    read actionName
    if [ -n "$actionName" ]; then
        file="$JS_DEST/$prj`capitalize_string $actionName`"Controller.js
        if [ -f "$file" ];then
            echo "$file was already defined,Please enter new one."
            continue
        else
            controller="$prj`capitalize_string $actionName`"Controller.js
            model="$prj`capitalize_string $actionName`"Model.js
            view="$prj`capitalize_string $actionName`"Page.js
            cp "$JUIC_GEN_HOME/controller.js" "$JS_DEST/$controller"
            echo "$controller created successfully"
            cp "$JUIC_GEN_HOME/model.js" "$JS_DEST/$model"
            echo "$model created successfully"
            cp "$JUIC_GEN_HOME/view.js" "$JS_DEST/$view"
            echo "$view created successfully"
            break
        fi
    fi
done
#create page file
PAGE_DEST="web/ui/$prj/pages"
page="$PAGE_DEST/"`split_action_name $actionName`".xhtml"
cp "$JUIC_GEN_HOME/page.xhtml" "$page"
echo "$page created successfully"
#last step replace the pattern with correct string existed in the template files
PRJ=`to_upper $prj`
ActionName=`capitalize_string $actionName`
action_name=`split_action_name $actionName`
ACTION_NAME=`to_upper $action_name`
#replace all patterns in controller
for fn in $controller $model $view
do
    sed -i "s/{prj}/$prj/g" "$JS_DEST/$fn"
    sed -i "s/{PRJ}/$PRJ/g" "$JS_DEST/$fn"
    sed -i "s/{ActionName}/$ActionName/g" "$JS_DEST/$fn"
    sed -i "s/{actionName}/$actionName/g" "$JS_DEST/$fn"
    sed -i "s/{ACTION_NAME}/$ACTION_NAME/g" "$JS_DEST/$fn"
    echo "all the patterns in $fn got replaced successfully"
done
#last step replace the patterns in page
sed -i "s/{prj}/$prj/g" $page
sed -i "s/{PRJ}/$PRJ/g" $page
sed -i "s/{ActionName}/$ActionName/g" $page
sed -i "s/{action_name}/$action_name/g" $page
sed -i "s/{ACTION_NAME}/$ACTION_NAME/g" $page
echo "all the patterns in $page got replaced successfully"
