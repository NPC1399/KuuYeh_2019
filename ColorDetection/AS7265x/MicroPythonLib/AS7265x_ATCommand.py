from pyb import UART

class AS7265x:
    def __init__(self,uart_channel,buadrate):
        self.uart = UART(uart_channel,buadrate)
        self.DataBuffer[]
    def __Version():
        self.uart.write("ATVERSW\r\n")
        SensorResponse = self.uart.read()
        print(SensorResponse)
    def __SystemHardware():
        