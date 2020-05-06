;creator：hsw@ccf
;用于显示rime@ccf输入法的任务栏菜单，便于快速调动和rime输入法相关的应用
; 1、安装相关
; 1.1、安装（管理员）
; 1.2、反安装（管理员）
; 1.3、配置修改后，重新部署
; 1.4、设置开机启动程序
; 2、输入法配置工具
; 2.1、Rime配置工具（第三方）：RimeControl@Win10
; 2.2、Rime配置工具（第三方）：RimeControl@Win7
; 2.3、Win10输入法配置工具（去除烦人的英文输入法）
; 2.4、添加简体中文美式键盘
; 3、自定义词库维护
; 3.1、一键生成八股文词库
; 3.2、打开自定义词库目录
; 3.3、访问搜狗细胞词库网站 pinyin.sogou.com/dict
; 3.4、访问百度分类词库网站 shurufa.baidu.com/dict
; 3.5、访问QQ分类词库网站 cdict.qq.pinyin.cn
; 4、
; 让脚本持续运行, 直到用户退出.
#Persistent
; 强制一个事例（单线程）
#SingleInstance, Force

; Recommended for new scripts due to its superior speed and reliability.
;SendMode Input

; 全局变量
global RimeTitle
global AppTitle
global AppVersion
RimeTitle=小狼毫（Rime）输入法
AppTitle=调度台程序
AppVersion = D3

; WinSetTitle, %RimeTitle%-%AppTitle%

; 在系统托盘建立一个弹出式窗口？
ShowTip(RimeTitle, "系统托盘中的【" AppTitle "】已经启动，可以在这里进行【" RimeTitle "】的一系列操作...")

; 设置工作路径
; SetWorkingDir, %A_ScriptDir%\..
SetWorkingDir, %A_ScriptDir%\

; 移除托盘图标的所有标准菜单项
Menu , tray , NoStandard
; 初始化菜单
; Menu, tray, Add ; 分隔符

;添加一级菜单
; Menu,tray,DeleteAll
Menu, tray, Add, %RimeTitle% 绿色便携版（%AppVersion%版）, MenuHandler
Menu, tray, Add, 【经典Ctrl加空格切换IME】, MenuHandler
Menu, tray, Add ; 分隔符
Menu, tray, Add, 0、一键自动安装（自动执行1.2~1.6步骤）, OneKeyAutoInstallHandler
Menu, tray, Add, 1、安装相关, MenuHandler
Menu, tray, Add, 2、输入法日常配置, MenuHandler
Menu, tray, Add, 3、自定义词库维护, MenuHandler
Menu, tray, Add, 4、打开自定义词库目录, OpenMyDirHandler
Menu, tray, Add ; 分隔符
Menu, tray, Add, 5、维护固顶词库, EditMyDictHandler
Menu, tray, Add, 6、导入其他输入法备份, MenuHandler
Menu, tray, Add, 7、切换五笔等其他输入法, RimeSettingHandler
Menu, tray, Add, 8、快速查看符号输入表, ViewSymbolsHandler
Menu, tray, Add ; 分隔符
Menu, tray, Add, 退出, ExitAppHandler

;添加项目到子菜单MySubmenu1，格式和上面一样
; menu, MySubmenu1, add ; 分隔符
Menu, MySubmenu1, Add, 1.1、备份用户词典（文本码表）, RimeBackupHandler
menu, MySubmenu1, add ; 分隔符
Menu, MySubmenu1, Add, 1.2、自动卸载并重新绿色安装, AutoIntallHandler
Menu, MySubmenu1, Add, 1.3、设置【%AppTitle%】跟随系统启动, SetAutoRunHandler
Menu, MySubmenu1, Add, 1.4、设置开机启动程序StartupDelayer, StartupDelayerHandler
menu, MySubmenu1, add ; 分隔符
Menu, MySubmenu1, Add, 1.5、添加简体中文美式键盘, AddChineseEnImeHandler
Menu, MySubmenu1, Add, 1.6、设置【简体中文美式键盘】为默认输入法, SetDefeatImeHandler
Menu, tray, Add, 1、安装相关, :MySubmenu1

;添加项目到子菜单MySubmenu2，格式和上面一样
Menu, MySubmenu2, Add, 2.1、Win10输入法配置工具（去除烦人的英文输入法）, TSFToolHandler
Menu, MySubmenu2, Add, 2.2、Rime配置工具（第三方）, RimeControlHandler
; menu, MySubmenu2, add ; 分隔符
; Menu, MySubmenu2, Add, 2.3、单独卸载旧的Rime输入法, UninstallHandler
; Menu, MySubmenu2, Add, 2.4、单独安装Rime输入法, InstallHandler
Menu, MySubmenu2, Add, 2.3、输入法自带功能, MenuHandler
menu, MySubmenu2, add ; 分隔符
Menu, MySubmenu2, Add,2.4、检查新版本 , RimeUpdateHandler
Menu, MySubmenu2, Add,2.5、一键卸载输入法, UninstallAllHandler
menu, MySubmenu2, add ; 分隔符
Menu, MySubmenu2, Add, 2.6、配置修改后，重新部署, RimeDeployHandler
Menu, tray, Add, 2、输入法日常配置, :MySubmenu2

Menu, MySubmenu8, Add,2.3.1、说明书 , RimeReadmeHandler
menu, MySubmenu8, add ; 分隔符
Menu, MySubmenu8, Add,2.3.2、输入法设定 , RimeSettingHandler
Menu, MySubmenu8, Add,2.3.3、用户词典管理 , RimeBackupHandler
Menu, MySubmenu8, Add,2.3.4、用户资料同步 , RimeSyncHandler
Menu, MySubmenu8, Add,2.3.5、重新部署 , RimeDeployHandler
menu, MySubmenu8, add ; 分隔符
Menu, MySubmenu8, Add,2.3.6、算法服务 , RimeWeaselServerHandler
menu, MySubmenu8, add ; 分隔符
Menu, MySubmenu8, Add,2.3.7、用户文件夹 , RimeUserDirHandler
Menu, MySubmenu8, Add,2.3.8、程序文件夹 , RimeWeaselDirHandler
menu, MySubmenu8, add ; 分隔符
Menu, MySubmenu8, Add,2.3.9、检查新版本 , RimeUpdateHandler
menu, MySubmenu8, add ; 分隔符
Menu, MySubmenu8, Add,2.3.10、安装选项 , RimeWeaselSetupHandler
Menu, MySubmenu8, Add,2.3.11、卸载输入法 , UninstallAllHandler
Menu, MySubmenu2, Add, 2.3、输入法自带功能, :MySubmenu8

;添加项目到子菜单MySubmenu2，格式和上面一样
Menu, MySubmenu3, Add, 3.1、一键生成八股文词库, CreateEssayHandler
menu, MySubmenu3, add ; 分隔符
Menu, MySubmenu3, Add, 3.2、生成Rime多音字词库（用于人名匹配）, CreatePinyinDuoYinZhiHandler
menu, MySubmenu3, add ; 分隔符
Menu, MySubmenu3, Add, 3.3、访问搜狗细胞词库网站, BrowseSogouHandler
Menu, MySubmenu3, Add, 3.4、访问百度分类词库网站 , BrowseBaiduHandler
Menu, MySubmenu3, Add, 3.5、访问QQ分类词库网站（谨慎使用，QQ提供的词库容易出错） , BrowseQqHandler
Menu, tray, Add, 3、自定义词库维护, :MySubmenu3

Menu, MySubmenu4, Add, 4.1、打开自定义词库目录, OpenMyDirHandler
menu, MySubmenu4, add ; 分隔符
Menu, MySubmenu4, Add, 4.2、打开Rime词库目录, OpenRimeDictDirHandler
Menu, MySubmenu4, Add, 4.3、打开搜狗@所在城市词库目录, OpenSogouCityDictDirHandler
menu, MySubmenu4, add ; 分隔符
Menu, MySubmenu4, Add, 4.4、打开搜狗细胞词库目录, OpenSogouDirHandler
Menu, MySubmenu4, Add, 4.5、打开百度分类词库目录 , OpenBaiduDirHandler
Menu, MySubmenu4, Add, 4.6、打开QQ分类词库目录 , OpenQqDirHandler
Menu, tray, Add, 4、打开自定义词库目录, :MySubmenu4

Menu, MySubmenu6, Add, 6.1、启动深蓝词库转换（其他输入法备份转换为Rime）, ImeWlConverterHandler
Menu, tray, Add, 6、导入其他输入法备份, :MySubmenu6

; 如果是Win10，使用Ctrl+Space替换Win+Space，恢复WinXp以来的输入法习惯
If A_OSVersion Contains 10
{
    ; 初始化按键
    ;ctrl+space代替win+space
    ^Space::#Space
    
    ;**************
    ; ^Space::#Space
    
    ;使用Ctrl+Space切换输入法，在菜单上体现出来
    menu, tray, Check, 【经典Ctrl加空格切换IME】
}
else
{
    menu, tray, Disable, 【经典Ctrl加空格切换IME】
}

Return

; 显示操作提示，用于代替Msgbox提示
ShowTip(title, context, seconds=30)
{
    ; MsgBox RimeTitle
    ; TrayTip [, Title, Text, Seconds, Options]注意senconds的取值一般在10到30之间
    TrayTip , %title%, %context%, %seconds%, 16
}

; 退出 
ExitAppHandler:
    ExitApp, 0
return

; 测试
MenuHandler:
    MsgBox You selected %A_ThisMenuItem% from the Menu %A_ThisMenu%.
return

; 1.0、一键自动设置1~6步骤
OneKeyAutoInstallHandler:
    ; 1.1、备份用户词典（文本码表）
    ; Gosub, RimeBackupHandler
    
    ; 1.2、自动卸载并重新绿色安装
    Gosub, AutoIntallHandler

    ; 1.3、设置跟随系统启动
    Gosub, SetAutoRunHandler

    ; 1.4、设置开机启动程序StartupDelayer
    Gosub, StartupDelayerHandler

    ; 1.5、添加简体中文美式键盘
    Gosub , AddChineseEnImeHandler

    ; 1.6、设置【简体中文美式键盘】为默认输入法
    Gosub SetDefeatImeHandler

    hint = 一键自动安装已经完成，请开始使用【%RimeTitle%】。
    
    ShowTip(RimeTitle,hint)
    MsgBox %hint%
return

; 1.1、备份用户词典（文本码表）
RimeBackupHandler:
    ; MsgBox RimeTitle
    hint = 本步骤用于备份已有用户数据，如果不需要，直接关闭【用户词典管理】界面即可。`n选择需要备份的输入法后，点击【导出文本码表】。
    
    ShowTip(RimeTitle,hint)
    MsgBox %hint%
    
    RunWait, WeaselDeployer.exe /dict, %A_WorkingDir%\weasel-0.14.3\
return

; 1.2、自动卸载并重新绿色安装
AutoIntallHandler:
    ; MsgBox %A_ScriptDir%\..
    ; MsgBox 选择需要备份的输入法后，点击【导出文本码表】
    ; Run *RunAs !pSetup.bat /restart, A_WorkingDir
    Gosub, UninstallHandler
    Gosub, InstallHandler
return

; 单独安装Rime输入法
InstallHandler:
    ; MsgBox %A_ScriptDir%\..
    ; MsgBox 选择需要备份的输入法后，点击【导出文本码表】
    RunWait *RunAs !pSetup.bat /restart, A_WorkingDir
return

; 4、单独卸载旧的Rime输入法
UninstallHandler:
    ; MsgBox %A_ScriptDir%\..
    ; MsgBox 选择需要备份的输入法后，点击【导出文本码表】
    RunWait *RunAs !pUninstall.bat /restart, A_WorkingDir
return

; 4、单独卸载旧的Rime输入法
UninstallAllHandler:
    ; MsgBox %A_ScriptDir%\..
    ; MsgBox 选择需要备份的输入法后，点击【导出文本码表】
    RunWait *RunAs !pUninstall.bat /restart, A_WorkingDir

    MsgBox 请在【开机自启管理-StartupDelayer】的【已延迟】列表中，移除【WeaselServer】（小狼毫算法服务）。`n请同时移除【%RimeTitle%-%AppTitle%】。
    ; 启动【开机自启管理-StartupDelayer】
    RunWait *RunAs Startup Delayer.exe /restart, %A_WorkingDir%\30-开机自启管理-StartupDelayer\
return

; 1.3、配置修改后，重新部署
RimeDeployHandler:
    ; MsgBox %A_ScriptDir%\..
    ; MsgBox 选择需要备份的输入法后，点击【导出文本码表】
    Run, WeaselDeployer.exe /deploy, %A_WorkingDir%\weasel-0.14.3\
return

; 1.3、设置跟随系统启动
SetAutoRunHandler:
    linkFileAllPath = %A_Startup%\%RimeTitle%-%AppTitle%.lnk
    
    StringReplace, exeFilename, A_ScriptName, .ahk , .exe, All
    
    exeSourceFilePath = %A_ScriptDir%\%exeFilename%
    
    ; 创建快捷方式
    FileCreateShortcut, %exeSourceFilePath%, %linkFileAllPath%, %A_WorkingDir%, , rime自启程序, %exeSourceFilePath%, 
    ; ShowTip(RimeTitle, 跟随系统启动完成！)
    MsgBox 【%AppTitle%】已经成功设置为【跟随系统启动】！
return

; 1.4 设置开机启动程序
StartupDelayerHandler:
    hint = 请务必设置【WeaselServer】（小狼毫算法服务）为延期启动（延期几秒即可）！`n将【WeaselServer】向上拖拽到【已延迟】列表即可。
    ShowTip(RimeTitle,hint)
    MsgBox %hint%
    
    ; 判断是否汉化
    EnvGet, EnvProgramData, ProgramData
    langSourceFilePath = %A_WorkingDir%\30-开机自启管理-StartupDelayer\zh-cn.lang
    langDestFilDir = %EnvProgramData%\r2 Studios\Startup Delayer\Translations\
    
    ; 判断目标语言文件是否存在？
    IfNotExist, %langDestFilDir%\zh-cn.lang
    {
        ; 不存在就复制一份语言文件到目标文件
        try {
            ;如果文件不存在，先创建目录
            FileCreateDir, %langDestFilDir%
            FileCopy, %langSourceFilePath%, %langDestFilDir%
        } catch e {
            ; 如果复制出现错误，系统会以英文界面显示，不影响使用
            MsgBox 复制StartupDelayer语言文件出现错误，StartupDelayer会以英文界面显示，不影响使用,16
        }
    }
    
    ; 启动【开机自启管理-StartupDelayer】
    RunWait *RunAs Startup Delayer.exe /restart, %A_WorkingDir%\30-开机自启管理-StartupDelayer\
return

;1.5 添加简体中文美式键盘
AddChineseEnImeHandler:
    RunWait, 添加简体中文美式键盘.exe /c, %A_WorkingDir%\10-输入法配置工具\
return

; 1.6、设置【简体中文美式键盘】为默认输入法
SetDefeatImeHandler:
    hint = 选择【美式键盘】，点击【启动】按钮。`n【美式键盘】出现在【启动的输入法】列表中时， 右键点击 【美式键盘】弹出菜单，点击【设置为默认输入法】！
    
    ShowTip(RimeTitle,hint)
    MsgBox %hint%
    
    ; 打开输入法配置，设置【简体中文美式键盘】为默认输入法
    Gosub, TSFToolHandler
return

; 2.1、Rime配置工具（第三方）
RimeControlHandler:
    
    If A_OSVersion Contains 10
    {
        Run, RimeControl@Win10.exe /c, %A_WorkingDir%\10-输入法配置工具\
    }
    else If A_OSVersion Contains 7,8 
    {
        Run, RimeControl@Win7.exe /c, %A_WorkingDir%\10-输入法配置工具\
    }
    else
    {
        MsgBox RimeControl配置工具（第三方）只支持Win10、Win7
    }
return

; 2.3、Win10输入法配置工具（去除烦人的英文输入法）
TSFToolHandler:
    
    If A_OSVersion Contains 10
    {
        if A_Is64bitOS 
        {
            RunWait *RunAs TSFTool_x64.exe /restart,%A_WorkingDir%\10-输入法配置工具\
        }
        else
        {
            RunWait *RunAs TSFTool_x86.exe /restart, %A_WorkingDir%\10-输入法配置工具\
        }
        
    }
    else
    {
        MsgBox Win10输入法配置工具只支持Win10，Win7版本请自行下载
    }
return

;一键生成八股文词库
CreateEssayHandler:
    RunWait, !一键生成八股文词库.cmd /c, %A_WorkingDir%\20-八股文词频库生成器\
    
    ; 编辑完成后，重新部署
    Gosub, RimeDeployHandler
return

; 3.3、生成Rime多音字词库（用于人名匹配）
CreatePinyinDuoYinZhiHandler:
    MsgBox 生成多音字词库，主要用于人名匹配，比如人名【乐乐】，输入【yy】、【ll】、【yl】、【ly】都可以匹配。
    Run %A_WorkingDir%\40-pinyin4j\
return

; 3.4、访问搜狗细胞词库网站
BrowseSogouHandler:
    Run https://pinyin.sogou.com/dict
return

; 3.5、访问百度分类词库网站
BrowseBaiduHandler:
    Run https://shurufa.baidu.com/dict
return

; 3.6、访问QQ分类词库网站
BrowseQqHandler:
    Run http://cdict.qq.pinyin.cn
return

; 4.1、打开自定义词库目录
OpenMyDirHandler:
    Run %A_WorkingDir%\20-八股文词频库生成器\
return

; 4.2、打开Rime词库目录
OpenRimeDictDirHandler:
    Run %A_WorkingDir%\20-八股文词频库生成器\90-Rime词组库.txt\
return

; 4.3、打开搜狗@所在城市词库目录
OpenSogouCityDictDirHandler:
    Run %A_WorkingDir%\20-八股文词频库生成器\00-搜狗@所在城市.scel\
return

; 4.4、打开搜狗细胞词库目录
OpenSogouDirHandler:
    Run %A_WorkingDir%\20-八股文词频库生成器\10-搜狗细胞词库.scel\
return

; 4.5、打开百度分类词库目录
OpenBaiduDirHandler:
    Run %A_WorkingDir%\20-八股文词频库生成器\20-百度分类词库.bdict\
return

; 4.6、打开QQ分类词库目录
OpenQqDirHandler:
    Run %A_WorkingDir%\20-八股文词频库生成器\30-QQ分类词库.qpyd\
return

; 5、维护固顶词库
EditMyDictHandler:
    hint = 编辑【%RimeTitle%】的固顶词库（custom_phrase.txt文件）。`n常用词汇将快速出现在输入法并置顶显示。`n编辑完成后自动重新部署，立即生效！`n输入法必选开启【custom_phrase】功能支持才会生效。
    
    ShowTip(RimeTitle,hint)
    MsgBox %hint%
    RunWait %A_WorkingDir%\AppData\custom_phrase.txt
    
    ; 编辑完成后，重新部署
    Gosub, RimeDeployHandler
return

; 6.1、启动深蓝词库转换（其他输入法备份转换为Rime）
ImeWlConverterHandler:
    hint = 可将其他输入法的输入习惯通过【深蓝词库转换】工具进行转换，如QQ输入法、搜狗输入法等
    
    ShowTip(RimeTitle,hint)
    MsgBox %hint%
    
    Run, 深蓝词库转换.exe, %A_WorkingDir%\20-八股文词频库生成器\
return

; 7、切换五笔等其他输入法
RimeSettingHandler:
    hint = 勾选别的输入法后即可生效
    
    ShowTip(RimeTitle,hint)
    
    Run, WeaselDeployer.exe /c, %A_WorkingDir%\weasel-0.14.3\
return

; 8.1、说明书
RimeReadmeHandler:
    Run, README.txt, %A_WorkingDir%\weasel-0.14.3\
return

; 8.4、用户资料同步
RimeSyncHandler:
    Run, WeaselDeployer.exe /sync, %A_WorkingDir%\weasel-0.14.3\
return

; 8.6、算法服务
RimeWeaselServerHandler:
    Run, WeaselServer.exe, %A_WorkingDir%\weasel-0.14.3\
return

; 8.7、用户文件夹
RimeUserDirHandler:
    Run, WeaselServer.exe /userdir, %A_WorkingDir%\weasel-0.14.3\
return

; 8.8、程序文件夹
RimeWeaselDirHandler:
    Run, WeaselServer.exe /weaseldir, %A_WorkingDir%\weasel-0.14.3\
return

; 8.9、检查新版本
RimeUpdateHandler:
    Run, WeaselServer.exe /update, %A_WorkingDir%\weasel-0.14.3\
return

; 8.10、安装选项
RimeWeaselSetupHandler:
    Run, WeaselSetup.exe, %A_WorkingDir%\weasel-0.14.3\
return

; 8、快速查看符号输入表
ViewSymbolsHandler:
    hint = 快速查看符号表，如：`n输入【/sx】会出现各种数字符号【±, ÷, ×, －, ＋, ∞】；`n输入【/sz】会出现各种数字符号【⓪, ①, ②, ③, ④】等。`n本功能要求输入法开启symbols支持。`n如果修改了内容，请重新部署。
    
    ShowTip(RimeTitle,hint)
    ; MsgBox %hint%
    Run, notepad.exe symbols.yaml, %A_ScriptDir%\weasel-0.14.3\data\
return