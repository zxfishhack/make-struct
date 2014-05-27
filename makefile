include Rule.make

.PHONY: test_pro
.PHONY: test_pro_clean

all : test_pro

distclean : clean
	-rm -rf bin
	-rm -rf objs
	-rm -rf lib

clean : test_pro_clean

test_pro:
	$(MAKE) -fmakefile.mk -C$(PROJECT_ROOT_PATH)/project_dir build MODULE=test_pro

test_pro_clean:
	$(MAKE) -fmakefile.mk -C$(PROJECT_ROOT_PATH)/project_dir clean MODULE=test_pro

