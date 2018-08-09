CXX=c++

LIB_PATH=\
	-L/home/sunwu/thirdpart -uv  \

INC_PATH=\
	-l/home/sunwu/thirdpart/include


COMPILE_OPT=-std=gnu++11 -g -g3 -Wall -Werror $(INC_PATH) 
LINK_OPT=$(LIB_PATH) -lpthread
TARGET_PATH=./bin
TARGET=$(TARGET_PATH)/ivy.a

OBJ_PATH=./.obj
OBJECTS=$(wildcard *.cpp)
OBJO=$(patsubst %.cpp,$(OBJ_PATH)/%.o, $(OBJECTS))
DEPS = $(OBJO:$(OBJ_PATH)/%.o=$(OBJ_PATH)/.%.d)

all:$(TARGET)
-include $(DEPS)
$(DEPS): $(OBJ_PATH)/.%.d: ./%.cpp
	@if [ ! -d "$(OBJ_PATH)" ]; then mkdir -pv $(OBJ_PATH); fi
	@$(CXX) -M $(COMPILE_OPT) $< > $@.$$$$; sed 's,\($*\)\.o[ :]*,$(OBJ_PATH)/\1.o $@ : ,g' < $@.$$$$ > $@; rm -f $@.$$$$

$(TARGET): $(OBJO)
	@if [ ! -d "$(TARGET_PATH)" ]; then mkdir -pv $(TARGET_PATH); fi
	@rm -rf $(TARGET)
	@ar cru $(TARGET) $(OBJO)
	@ranlib $(TARGET)

$(OBJO): $(OBJ_PATH)/%.o:%.cpp
	@if [ ! -d "$(OBJ_PATH)" ]; then mkdir -pv $(OBJ_PATH); fi
	$(CXX) -c $(COMPILE_OPT) $< -o $@

install:

clean:

PHONY: clean all install

