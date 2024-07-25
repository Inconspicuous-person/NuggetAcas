from asciimatics.screen import Screen
import time
import pickle
import socket

s = socket.socket(socket.AF_INET,
                  socket.SOCK_STREAM)

s.setblocking(1)
#s.settimeout(0.5)
s.bind(("0.0.0.0", 5617))


def App(screen):
    screen.move(0, 0)
    screen.draw(screen.width, screen.height,colour=1,thin=1)

    screen.move(screen.width, 0)
    #screen.draw(0, screen.height,colour=1,thin=1)
    screen.print_at("NUGGET MICROSYSTEMS ACAS", int((screen.width/2)-12), int(screen.height/2),6)
    screen.print_at("WAITING FOR CONNECTION", int((screen.width/2)-11),int(screen.height/2)+1,6)
    screen.refresh()
    #time.sleep(3)
    while True:

        s.listen(1)
        c, addr = s.accept()
        data = c.recv(32786)

        Warnings = pickle.loads(data)
        screen.clear_buffer(0,1,0)



        currentY = 0
        for a in range(len(Warnings[0])):
            #print(Warnings[a][0])
            screen.print_at(Warnings[0][a][0], 1, currentY, 7, 0)
            currentY=currentY+1

            for b in range(len(Warnings[0][a][1])):
                #print(' -'+Warnings[a][1][b])
                if Warnings[0][a][1][b][1] == "INFO":
                    screen.print_at(' -'+Warnings[0][a][1][b][0], 1, currentY, 6, 0)
                if Warnings[0][a][1][b][1] == "CAUTION":
                    screen.print_at(' -'+Warnings[0][a][1][b][0], 1, currentY, 3, 0)
                if Warnings[0][a][1][b][1] == "WARNING":
                    screen.print_at(' -'+Warnings[0][a][1][b][0], 1, currentY, 1, 0)
                if Warnings[0][a][1][b][1] == "CRITICAL":
                    screen.print_at(' -'+Warnings[0][a][1][b][0], 1, currentY, 1, 0)
                if Warnings[0][a][1][b][1] == "EMERGENCY":
                    screen.print_at(' -'+Warnings[0][a][1][b][0], 1, currentY, 5, 0)
                currentY=currentY+1
                if Warnings[0][a][1][b][2] != "0":
                    fixes_split = Warnings[0][a][1][b][2].split('\n')

                    for i in range(len(fixes_split)):
                        screen.print_at('    -' + fixes_split[i], 1, currentY, 6, 0)
                        currentY = currentY + 1


        #screen.move(60,0)
        #screen.draw(60,screen.height)

        screen.refresh()


Screen.wrapper(App)
