#include <iiWhatsNew.h>

#include <QtCore/QTextStream>
#include <cstring>

static_assert(__cplusplus >= 202002L, "C++20 is required");
static_assert(QT_VERSION == QT_VERSION_CHECK(6, 8, 3), "Qt 6.8.3 is required");

int main()
{
    const QString message = iiWhatsNew::helloWorld();
    QTextStream(stdout) << message << Qt::endl;
    return message == QStringLiteral("Hello world!")
            && std::strcmp(qVersion(), "6.8.3") == 0
        ? 0 : 1;
}
