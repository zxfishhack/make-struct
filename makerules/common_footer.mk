ifndef $(COMMON_FOOTER_MK)
COMMON_FOORTER_MK = 1

OBJS_=$(patsubst %.cpp,%.o, $(SOURCES))
OBJS__=$(patsubst %.cc,%.lcco, $(OBJS_))
OBJS___=$(patsubst %.c,%.co, $(OBJS__))
OBJS=$(subst ../,,$(OBJS___))

COMMON_OBJS_=$(subst .cpp,.eo,$(COMMON_SOURCES))
COMMON_OBJS__=$(subst .cc,.ecco,$(COMMON_OBJS_))
COMMON_OBJS=$(subst .c,eco,$(COMMON_OBJS__))

OBJS+= $(COMMON_OBJS)

OBJ_PATH=$(subst ../,,$(DEPENDPATH))

OBJ_DIR=$(OBJ_BASE_DIR)/$(MODULE)

LIB = lib$(MODULE).a

vpath %.o $(OBJ_DIR)
vpath %.co $(OBJ_DIR)
vpath %.eo $(OBJ_DIR)
vpath %.ecco $(OBJ_DIR)
vpath %.eco $(OBJ_DIR)
vpath %.lcco $(OBJ_DIR)
vpath %.cc $(COMMON_ROOT_PATH)
vpath %.cpp $(COMMON_ROOT_PATH)
vpath %.c $(COMMON_ROOT_PATH)

EXE = $(EXE_DIR)/$(MODULE)

SO_LIB = $(LIB_DIR)/lib$(MODULE).so

.cpp.o:
	@echo \# $(MODULE): $(PLATFORM): Compiling $<
	$(CXX) -c $(CXX_OPTS) $(OPTI_OPTS) $(DEFINE) $(INCLUDE) -o$(OBJ_DIR)/$@ $<

%.co: %.c
	@echo \# $(MODULE): $(PLATFORM): Compiling $<
	$(CC) -c $(CC_OPTS) $(OPTI_OPTS) $(DEFINE) $(INCLUDE) -o$(OBJ_DIR)/$@ $<

%.lcco: %.cc
	@echo \# $(MODULE): $(PLATFORM): Compiling $<
	$(CC) -c $(CXX_OPTS) $(OPTI_OPTS) $(DEFINE) $(INCLUDE) -o$(OBJ_DIR)/$@ $<

%.ecco: %.cc
	@echo \# $(MODULE): $(PLATFORM): Compiling $<
	$(CXX) -c $(CXX_OPTS) $(OPTI_OPTS) $(DEFINE) $(INCLUDE) -o$(OBJ_DIR)/$@ $<

%.eo: %.cpp
	@echo \# $(MODULE): $(PLATFORM): Compiling $<
	$(CXX) -c $(CXX_OPTS) $(OPTI_OPTS) $(DEFINE) $(INCLUDE) -o$(OBJ_DIR)/$@ $<

%eco: %.c
	@echo \# $(MODULE): $(PLATFORM): Compiling $<
	$(CXX) -c $(CXX_OPTS) $(OPTI_OPTS) $(DEFINE) $(INCLUDE) -o$(OBJ_DIR)/$@ $<


obj: $(OBJS) 
	@echo \# $(MODULE): $(PLATFORM): end build objects.

clean:
	@echo \# $(MODULE): $(PLATFORM): Deleting temporary files
	-rm -f $(LIB_DIR)/$(LIB)
	-rm -f $(OBJ_DIR)/*.*
	-rm -f MAKEFILE_$(PLATFORM).DEPEND

MKDEP = $(CXX) $(CXX_OPTS) $(DEFINE) $(INCLUDE) -MM -MT _f_u_c_k_

depend: $(SOURCES)
#	@echo \# $(MODULE): $(PLATFORM): Making Directories, if not already created
	-mkdir -p $(LIB_DIR)
	-mkdir -p $(OBJ_DIR)
	-mkdir -p $(EXE_DIR)
	@echo \# Common Path: $(COMMON_ROOT_PATH)
	-cd $(OBJ_DIR); mkdir -p $(OBJ_PATH)
	-rm -f MAKEFILE_$(PLATFORM).DEPEND
	@echo \# $(MODULE): $(PLATFORM): Building dependancies
	@for file in $(SOURCES); do\
		$(MKDEP) $$file > .tmp; \
		$(PROJECT_ROOT_PATH)/makerules/swap.sh $$file .tmp >> MAKEFILE_$(PLATFORM).DEPEND; \
		rm .tmp; \
	done
#	$(MKDEP)

so: obj
	@echo \# $(MODULE): $(PLATFORM): Linking to .so
	cd $(OBJ_DIR) ; $(LD) $(OBJS) $(LD_OPTS) -fPIC -shared -o $(SO_LIB)
	@echo \#

lib: $(LIB_DIR)/$(LIB)

$(LIB_DIR)/$(LIB) : obj
	@echo \# $(MODULE): $(PLATFORM): Creating archive $(LIB)
	cd $(OBJ_DIR) ; $(AR) $(AR_OPTS) $(LIB_DIR)/$(LIB) $(OBJS)
	@echo \# 

exe: obj
	@echo \# $(MODULE): $(PLATFORM): Linking
	cd $(OBJ_DIR) ; $(LD) $(OBJS) $(LD_OPTS) -o$(EXE)
	@echo \#

libs:
	$(MAKE) -fmakefile.mk MODULE=$(MODULE) $(TARGET)

all: build

install:

-include MAKEFILE_$(PLATFORM).DEPEND

endif
