#include <GLFW/glfw3.h>

int main() {
    // 初始化GLFW库
    if (!glfwInit()) {
        return -1;
    }

    // 配置GLFW窗口参数
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    // 创建800x600像素的窗口
    GLFWwindow* window = glfwCreateWindow(800, 600, "GLFW示例", NULL, NULL);
    if (!window) {
        glfwTerminate();
        return -1;
    }

    // 设置当前上下文
    glfwMakeContextCurrent(window);

    // 设置视口大小
    glViewport(0, 0, 800, 600);

    // 主渲染循环
    while (!glfwWindowShouldClose(window)) {
        // 清屏颜色(深蓝色)
        glClearColor(0.1f, 0.2f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        // 绘制彩色三角形
        glBegin(GL_TRIANGLES);
        glColor3f(1.0f, 0.0f, 0.0f);  // 红
        glVertex2f(-0.5f, -0.5f);
        glColor3f(0.0f, 1.0f, 0.0f);  // 绿
        glVertex2f(0.5f, -0.5f);
        glColor3f(0.0f, 0.0f, 1.0f);  // 蓝
        glVertex2f(0.0f, 0.5f);
        glEnd();

        // 交换缓冲区
        glfwSwapBuffers(window);
        // 处理事件
        glfwPollEvents();
    }

    // 清理资源
    glfwTerminate();
    return 0;
}
