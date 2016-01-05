#!/usr/bin/python

import MySQLdb

def db_get(mac):
    db = MySQLdb.connect('localhost', 'feng', '123', 'hostapdserver')
    cursor = db.cursor()
    sql = "select strpsk from user where mac='%s'" % (mac)
    try:
        cursor.execute(sql)
        result = cursor.fetchone()
    except MySQLdb.Error, e:
        print 'Error %d: %s' % (e.args[0], e.args[1])
    finally:
        db.close()
        return result

def db_set(mac, strpsk):
    db = MySQLdb.connect('localhost', 'feng', '123', 'hostapdserver')
    cursor = db.cursor()
    sql = "insert into user values('%s', '%s')" % (mac, strpsk)
    try:
        cursor.execute(sql)
        db.commit()
    except MySQLdb.Error, e:
        print 'Error %d: %s' % (e.args[0], e.args[1])
        db.rollback()
    finally:
        db.close()

if __name__ == '__main__':
    mac = 'ac:f7:f3:59:0a:2c'
    result = db_get(mac)
    if not result:
        print 'do not have ', mac
    strpsk = 'abcdefghijklmnopqrstuvwxyz123456'
    db_set(mac, strpsk)
    result = db_get(mac)
    if result:
        print 'have strpsk ', strpsk


