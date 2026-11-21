import { Role } from "../../generated/prisma/enums"
import bcript from "bcryptjs"
import { defineConfig } from "prisma/config";
import prismaConfig from "../../prisma7.config";
import config from "../config";
import { prisma } from "../lib/prisma";
import { error } from "node:console";

export const seedAdmin = async () =>{
    try {
        const isAdminExist = await prisma.user.findFirst({
            where: {
                role: Role.ADMIN
            }
        });
        if(isAdminExist){
            console.log("Admin is already exist");
            return;
        }

        const name = config.admin_name
        const email = config.admin_email
        const password = config.admin_password
        const hashedPassword = await bcript.hash(password, Number(config.bcrypt_salt_rounds))

        if(!name || !email || !password){
            throw new Error ("Admin's  Name, Email , password missing in env file")
        }
        const admin = await prisma.user.create({
            data: {
                name,
                email,
                password: hashedPassword,
                role : Role.ADMIN,
                emailVerified: true,
            }
        })
        console.log("Admin created: ", admin);
    
    } catch (error) {
        console.log("Error seeding Admin: ",error);
        await prisma.user.delete({
            where: {
                email: config.admin_email
            }
        })
        
    }
}
export const seedTesterTeacher = async () =>{
    try {
        const isTesterTeacherExist = await prisma.user.findUnique({
            where: {
                email: config.tester_teacher_email
            }
        });
        if(isTesterTeacherExist){
            console.log("Tester Teacher is already exist");
            return;
        }

        const name = config.tester_teacher_name
        const email = config.tester_teacher_email
        const password = config.tester_teacher_password
        const hashedPassword = await bcript.hash(password, Number(config.bcrypt_salt_rounds))

        if(!name || !email || !password){
            throw new Error ("Tester Teacher's  Name, Email , password missing in env file")
        }
        const TesterTeacher = await prisma.user.create({
            data: {
                name,
                email,
                password: hashedPassword,
                role : Role.TEACHER,
                needPasswordChange:false,
                emailVerified: true,
            }
        })
        console.log("Tester Teacher created: ", TesterTeacher);
    
    } catch (error) {
        console.log("Error seeding Tester Teacher: ",error);
        await prisma.user.delete({
            where: {
                email: config.tester_teacher_email
            }
        })
        
    }
}
export const seedTesterStudent = async () =>{
    try {
        const isTesterStudentExist = await prisma.user.findUnique({
            where: {
                email: config.tester_student_email
            }
        });
        if(isTesterStudentExist){
            console.log("Tester Student is already exist");
            return;
        }

        const name = config.tester_student_name
        const email = config.tester_student_email
        const password = config.tester_student_password
        const hashedPassword = await bcript.hash(password, Number(config.bcrypt_salt_rounds))

        if(!name || !email || !password){
            throw new Error ("Tester student's  Name, Email , password missing in env file")
        }
        const TesterStudent = await prisma.user.create({
            data: {
                name,
                email,
                password: hashedPassword,
                role : Role.STUDENT,
                needPasswordChange: false,
                emailVerified: true,
            }
        })
        console.log("Tester Student created: ", TesterStudent);
    
    } catch (error) {
        console.log("Error seeding Tester Student: ",error);
        await prisma.user.delete({
            where: {
                email: config.tester_student_email
            }
        })
        
    }
}
