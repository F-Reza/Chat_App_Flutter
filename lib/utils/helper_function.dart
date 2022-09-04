
import 'package:intl/intl.dart';

String getFormatDate(DateTime dt, String format) =>
    DateFormat(format).format(dt);