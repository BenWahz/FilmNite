//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import SQLite3

class Database
{
    init()
    {
        db = openDatabase()
        createTables()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTables() {
        let createUserTableString = "CREATE TABLE IF NOT EXISTS Users(username VARCHAR(16), name VARCHAR(32));"
        var createUserTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createUserTableString, -1, &createUserTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createUserTableStatement) == SQLITE_DONE
            {
                print("User table created.")
            } else {
                print("User table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createUserTableStatement)
        
        let createMovieTableString = "CREATE TABLE IF NOT EXISTS Movie(name VARCHAR(64));"
        var createUserMovieStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createMovieTableString, -1, &createUserMovieStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createUserMovieStatement) == SQLITE_DONE
            {
                print("Movie table created.")
            } else {
                print("Movie table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createUserMovieStatement)
    }
    
    
    func insertUser (user: User)
    {
        let insertStatementString = "INSERT INTO User (username, name) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            //sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 1, (user.username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (user.name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func selectUsers() -> [User] {
        let queryStatementString = "SELECT * FROM Users;"
        var queryStatement: OpaquePointer? = nil
        var psns : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //let id = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                psns.append(User(username: username, name: name))
                print("Query Result:")
                print("\(username) | \(name)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    //func deleteByID(id:Int) {
    //    let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
    //    var deleteStatement: OpaquePointer? = nil
    //    if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
    //       sqlite3_bind_int(deleteStatement, 1, Int32(id))
    //        if sqlite3_step(deleteStatement) == SQLITE_DONE {
    //            print("Successfully deleted row.")
    //        } else {
    //            print("Could not delete row.")
    //        }
    //    } else {
    //        print("DELETE statement could not be prepared")
    //   }
    //    sqlite3_finalize(deleteStatement)
    //}
    
}
