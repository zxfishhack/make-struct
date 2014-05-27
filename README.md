# make-base项目结构

# 依赖
qmake : 用于生成源文件项目结构

# 使用方法
在每个子目录下使用qmake -project以生成项目文件，文件名需与模块名相同，可不与目录名相同

修改project_dir下的makefile.mk模板，添加自定义的参数

其中build部分，TARGET的可选项为so exe lib，依次为生成动态库、可执行文件及静态库

修改主目录下的makefile，为新的子目录添加生成入口，格式如下：

module_name:

	$(MAKE) -fmakefile.mk -C$(PROJECT_ROOT_PATH)/<subdir> build MODULE=<module_name>
	
module_name_clean:

	$(MAKE) -fmakefile.mk -C$(PROJECT_ROOT_PATH)/<subdir> clean MODULE=<module_name>

在开头的.PHONY加入生成入口声明
