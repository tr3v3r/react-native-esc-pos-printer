namespace ReactNativeEscPosPrinter
{
  internal sealed class Epos2CallbackCode
  {
    public static readonly int CODE_SUCCESS = 0;
    public static readonly int CODE_ERR_TIMEOUT = 1;
    public static readonly int CODE_ERR_NOT_FOUND = 2;
    public static readonly int CODE_ERR_AUTORECOVER = 3;
    public static readonly int CODE_ERR_COVER_OPEN = 4;
    public static readonly int CODE_ERR_CUTTER = 5;
    public static readonly int CODE_ERR_MECHANICAL = 6;
    public static readonly int CODE_ERR_EMPTY = 7;
    public static readonly int CODE_ERR_UNRECOVERABLE = 8;
    public static readonly int CODE_ERR_SYSTEM = 9;
    public static readonly int CODE_ERR_PORT = 10;
    public static readonly int CODE_ERR_INVALID_WINDOW = 11;
    public static readonly int CODE_ERR_JOB_NOT_FOUND = 12;
    public static readonly int CODE_PRINTING = 13;
    public static readonly int CODE_ERR_SPOOLER = 14;
    public static readonly int CODE_ERR_BATTERY_LOW = 15;
    public static readonly int CODE_ERR_TOO_MANY_REQUESTS = 16;
    public static readonly int CODE_ERR_REQUEST_ENTITY_TOO_LARGE = 17;
    public static readonly int CODE_CANCELED = 18;
    public static readonly int CODE_ERR_NO_MICR_DATA = 19;
    public static readonly int CODE_ERR_ILLEGAL_LENGTH = 20;
    public static readonly int CODE_ERR_NO_MAGNETIC_DATA = 21;
    public static readonly int CODE_ERR_RECOGNITION = 22;
    public static readonly int CODE_ERR_READ = 23;
    public static readonly int CODE_ERR_NOISE_DETECTED = 24;
    public static readonly int CODE_ERR_PAPER_JAM = 25;
    public static readonly int CODE_ERR_PAPER_PULLED_OUT = 26;
    public static readonly int CODE_ERR_CANCEL_FAILED = 27;
    public static readonly int CODE_ERR_PAPER_TYPE = 28;
    public static readonly int CODE_ERR_WAIT_INSERTION = 29;
    public static readonly int CODE_ERR_ILLEGAL = 30;
    public static readonly int CODE_ERR_INSERTED = 31;
    public static readonly int CODE_ERR_WAIT_REMOVAL = 32;
    public static readonly int CODE_ERR_DEVICE_BUSY = 33;
    public static readonly int CODE_ERR_IN_USE = 34;
    public static readonly int CODE_ERR_CONNECT = 35;
    public static readonly int CODE_ERR_DISCONNECT = 36;
    public static readonly int CODE_ERR_MEMORY = 37;
    public static readonly int CODE_ERR_PROCESSING = 38;
    public static readonly int CODE_ERR_PARAM = 39;
    public static readonly int CODE_ERR_GET_JSON_SIZE = 40;
    public static readonly int CODE_ERR_DIFFERENT_MODEL = 41;
    public static readonly int CODE_ERR_DIFFERENT_VERSION = 42;
    public static readonly int CODE_ERR_DATA_CORRUPTED = 43;
    public static readonly int CODE_ERR_IO = 44;
    public static readonly int CODE_RETRY = 45;
    public static readonly int CODE_ERR_RECOVERY_FAILURE = 46;
    public static readonly int CODE_ERR_JSON_FORMAT = 47;
    public static readonly int CODE_NO_PASSWORD = 48;
    public static readonly int CODE_ERR_INVALID_PASSWORD = 49;
    public static readonly int CODE_ERR_FAILURE = 255;

    public Epos2CallbackCode()
    {
    }
  }
}
