#pragma once

#include <QtCore/QString>
#include <QtCore/qglobal.h>

#if defined(IIWHATSNEW_BUILDING_LIBRARY)
#define IIWHATSNEW_EXPORT Q_DECL_EXPORT
#else
#define IIWHATSNEW_EXPORT Q_DECL_IMPORT
#endif

namespace iiWhatsNew {

[[nodiscard]] IIWHATSNEW_EXPORT QString helloWorld();

} // namespace iiWhatsNew
