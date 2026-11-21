/*
  Warnings:

  - The primary key for the `academic_groups` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `academic_levels` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `academic_programs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `academic_sessions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `audit_logs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `curriculum_subjects` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `exam_fees` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `exam_subjects` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `exams` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `marks` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `payment_transactions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `payments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `results` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `sections` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `student_academic_records` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `student_subjects` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `students` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `teacher_assignments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `teachers` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[rollNumber]` on the table `student_academic_records` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[registrationNumber]` on the table `student_academic_records` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[googleId]` on the table `users` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'BLOCKED', 'DELETED');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "AuthProvider" AS ENUM ('GOOGLE', 'CREDENTIAL');

-- DropForeignKey
ALTER TABLE "academic_groups" DROP CONSTRAINT "academic_groups_academicLevelId_fkey";

-- DropForeignKey
ALTER TABLE "academic_levels" DROP CONSTRAINT "academic_levels_programId_fkey";

-- DropForeignKey
ALTER TABLE "audit_logs" DROP CONSTRAINT "audit_logs_userId_fkey";

-- DropForeignKey
ALTER TABLE "curriculum_subjects" DROP CONSTRAINT "curriculum_subjects_academicGroupId_fkey";

-- DropForeignKey
ALTER TABLE "curriculum_subjects" DROP CONSTRAINT "curriculum_subjects_academicLevelId_fkey";

-- DropForeignKey
ALTER TABLE "exam_fees" DROP CONSTRAINT "exam_fees_examId_fkey";

-- DropForeignKey
ALTER TABLE "exam_fees" DROP CONSTRAINT "exam_fees_studentId_fkey";

-- DropForeignKey
ALTER TABLE "exam_subjects" DROP CONSTRAINT "exam_subjects_curriculumSubjectId_fkey";

-- DropForeignKey
ALTER TABLE "exam_subjects" DROP CONSTRAINT "exam_subjects_examId_fkey";

-- DropForeignKey
ALTER TABLE "exams" DROP CONSTRAINT "exams_academicGroupId_fkey";

-- DropForeignKey
ALTER TABLE "exams" DROP CONSTRAINT "exams_academicLevelId_fkey";

-- DropForeignKey
ALTER TABLE "exams" DROP CONSTRAINT "exams_academicSessionId_fkey";

-- DropForeignKey
ALTER TABLE "marks" DROP CONSTRAINT "marks_enteredBy_fkey";

-- DropForeignKey
ALTER TABLE "marks" DROP CONSTRAINT "marks_examSubjectId_fkey";

-- DropForeignKey
ALTER TABLE "marks" DROP CONSTRAINT "marks_studentId_fkey";

-- DropForeignKey
ALTER TABLE "payment_transactions" DROP CONSTRAINT "payment_transactions_paymentId_fkey";

-- DropForeignKey
ALTER TABLE "payments" DROP CONSTRAINT "payments_examFeeId_fkey";

-- DropForeignKey
ALTER TABLE "payments" DROP CONSTRAINT "payments_studentId_fkey";

-- DropForeignKey
ALTER TABLE "results" DROP CONSTRAINT "results_examId_fkey";

-- DropForeignKey
ALTER TABLE "results" DROP CONSTRAINT "results_studentId_fkey";

-- DropForeignKey
ALTER TABLE "sections" DROP CONSTRAINT "sections_academicGroupId_fkey";

-- DropForeignKey
ALTER TABLE "sections" DROP CONSTRAINT "sections_academicLevelId_fkey";

-- DropForeignKey
ALTER TABLE "student_academic_records" DROP CONSTRAINT "student_academic_records_academicGroupId_fkey";

-- DropForeignKey
ALTER TABLE "student_academic_records" DROP CONSTRAINT "student_academic_records_academicLevelId_fkey";

-- DropForeignKey
ALTER TABLE "student_academic_records" DROP CONSTRAINT "student_academic_records_academicSessionId_fkey";

-- DropForeignKey
ALTER TABLE "student_academic_records" DROP CONSTRAINT "student_academic_records_sectionId_fkey";

-- DropForeignKey
ALTER TABLE "student_academic_records" DROP CONSTRAINT "student_academic_records_studentId_fkey";

-- DropForeignKey
ALTER TABLE "student_subjects" DROP CONSTRAINT "student_subjects_curriculumSubjectId_fkey";

-- DropForeignKey
ALTER TABLE "student_subjects" DROP CONSTRAINT "student_subjects_studentAcademicRecordId_fkey";

-- DropForeignKey
ALTER TABLE "student_subjects" DROP CONSTRAINT "student_subjects_studentId_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_userId_fkey";

-- DropForeignKey
ALTER TABLE "teacher_assignments" DROP CONSTRAINT "teacher_assignments_academicSessionId_fkey";

-- DropForeignKey
ALTER TABLE "teacher_assignments" DROP CONSTRAINT "teacher_assignments_curriculumSubjectId_fkey";

-- DropForeignKey
ALTER TABLE "teacher_assignments" DROP CONSTRAINT "teacher_assignments_sectionId_fkey";

-- DropForeignKey
ALTER TABLE "teacher_assignments" DROP CONSTRAINT "teacher_assignments_teacherId_fkey";

-- DropForeignKey
ALTER TABLE "teachers" DROP CONSTRAINT "teachers_userId_fkey";

-- AlterTable
ALTER TABLE "academic_groups" DROP CONSTRAINT "academic_groups_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "academicLevelId" SET DATA TYPE TEXT,
ADD CONSTRAINT "academic_groups_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "academic_groups_id_seq";

-- AlterTable
ALTER TABLE "academic_levels" DROP CONSTRAINT "academic_levels_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "programId" SET DATA TYPE TEXT,
ALTER COLUMN "yearNumber" SET DATA TYPE TEXT,
ADD CONSTRAINT "academic_levels_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "academic_levels_id_seq";

-- AlterTable
ALTER TABLE "academic_programs" DROP CONSTRAINT "academic_programs_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "academic_programs_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "academic_programs_id_seq";

-- AlterTable
ALTER TABLE "academic_sessions" DROP CONSTRAINT "academic_sessions_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "academic_sessions_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "academic_sessions_id_seq";

-- AlterTable
ALTER TABLE "audit_logs" DROP CONSTRAINT "audit_logs_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "audit_logs_id_seq";

-- AlterTable
ALTER TABLE "curriculum_subjects" DROP CONSTRAINT "curriculum_subjects_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "academicLevelId" SET DATA TYPE TEXT,
ALTER COLUMN "academicGroupId" SET DATA TYPE TEXT,
ADD CONSTRAINT "curriculum_subjects_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "curriculum_subjects_id_seq";

-- AlterTable
ALTER TABLE "exam_fees" DROP CONSTRAINT "exam_fees_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "examId" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ALTER COLUMN "amount" SET DATA TYPE DOUBLE PRECISION,
ADD CONSTRAINT "exam_fees_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "exam_fees_id_seq";

-- AlterTable
ALTER TABLE "exam_subjects" DROP CONSTRAINT "exam_subjects_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "examId" SET DATA TYPE TEXT,
ALTER COLUMN "curriculumSubjectId" SET DATA TYPE TEXT,
ADD CONSTRAINT "exam_subjects_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "exam_subjects_id_seq";

-- AlterTable
ALTER TABLE "exams" DROP CONSTRAINT "exams_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "academicSessionId" SET DATA TYPE TEXT,
ALTER COLUMN "academicLevelId" SET DATA TYPE TEXT,
ALTER COLUMN "academicGroupId" SET DATA TYPE TEXT,
ADD CONSTRAINT "exams_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "exams_id_seq";

-- AlterTable
ALTER TABLE "marks" DROP CONSTRAINT "marks_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "examSubjectId" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ALTER COLUMN "enteredBy" SET DATA TYPE TEXT,
ADD CONSTRAINT "marks_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "marks_id_seq";

-- AlterTable
ALTER TABLE "payment_transactions" DROP CONSTRAINT "payment_transactions_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "paymentId" SET DATA TYPE TEXT,
ALTER COLUMN "amount" SET DATA TYPE DOUBLE PRECISION,
ADD CONSTRAINT "payment_transactions_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "payment_transactions_id_seq";

-- AlterTable
ALTER TABLE "payments" DROP CONSTRAINT "payments_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "examFeeId" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ALTER COLUMN "amount" SET DATA TYPE DOUBLE PRECISION,
ADD CONSTRAINT "payments_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "payments_id_seq";

-- AlterTable
ALTER TABLE "results" DROP CONSTRAINT "results_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "examId" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ADD CONSTRAINT "results_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "results_id_seq";

-- AlterTable
ALTER TABLE "sections" DROP CONSTRAINT "sections_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "academicLevelId" SET DATA TYPE TEXT,
ALTER COLUMN "academicGroupId" SET DATA TYPE TEXT,
ALTER COLUMN "capacity" SET DATA TYPE TEXT,
ADD CONSTRAINT "sections_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "sections_id_seq";

-- AlterTable
ALTER TABLE "student_academic_records" DROP CONSTRAINT "student_academic_records_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ALTER COLUMN "academicSessionId" SET DATA TYPE TEXT,
ALTER COLUMN "academicLevelId" SET DATA TYPE TEXT,
ALTER COLUMN "academicGroupId" SET DATA TYPE TEXT,
ALTER COLUMN "sectionId" SET DATA TYPE TEXT,
ADD CONSTRAINT "student_academic_records_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "student_academic_records_id_seq";

-- AlterTable
ALTER TABLE "student_subjects" DROP CONSTRAINT "student_subjects_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ALTER COLUMN "studentAcademicRecordId" SET DATA TYPE TEXT,
ALTER COLUMN "curriculumSubjectId" SET DATA TYPE TEXT,
ADD CONSTRAINT "student_subjects_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "student_subjects_id_seq";

-- AlterTable
ALTER TABLE "students" DROP CONSTRAINT "students_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "students_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "students_id_seq";

-- AlterTable
ALTER TABLE "teacher_assignments" DROP CONSTRAINT "teacher_assignments_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "teacherId" SET DATA TYPE TEXT,
ALTER COLUMN "sectionId" SET DATA TYPE TEXT,
ALTER COLUMN "curriculumSubjectId" SET DATA TYPE TEXT,
ALTER COLUMN "academicSessionId" SET DATA TYPE TEXT,
ADD CONSTRAINT "teacher_assignments_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "teacher_assignments_id_seq";

-- AlterTable
ALTER TABLE "teachers" DROP CONSTRAINT "teachers_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "teachers_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "teachers_id_seq";

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
ADD COLUMN     "authProvider" "AuthProvider" NOT NULL DEFAULT 'CREDENTIAL',
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "emailVerified" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "googleId" TEXT,
ADD COLUMN     "imagePublicId" TEXT NOT NULL DEFAULT '',
ADD COLUMN     "imageURL" TEXT NOT NULL DEFAULT '',
ADD COLUMN     "isDeleted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "needPasswordChange" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "users_id_seq";

-- CreateIndex
CREATE UNIQUE INDEX "student_academic_records_rollNumber_key" ON "student_academic_records"("rollNumber");

-- CreateIndex
CREATE UNIQUE INDEX "student_academic_records_registrationNumber_key" ON "student_academic_records"("registrationNumber");

-- CreateIndex
CREATE UNIQUE INDEX "users_googleId_key" ON "users"("googleId");

-- AddForeignKey
ALTER TABLE "academic_groups" ADD CONSTRAINT "academic_groups_academicLevelId_fkey" FOREIGN KEY ("academicLevelId") REFERENCES "academic_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "academic_levels" ADD CONSTRAINT "academic_levels_programId_fkey" FOREIGN KEY ("programId") REFERENCES "academic_programs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_academic_records" ADD CONSTRAINT "student_academic_records_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_academic_records" ADD CONSTRAINT "student_academic_records_academicSessionId_fkey" FOREIGN KEY ("academicSessionId") REFERENCES "academic_sessions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_academic_records" ADD CONSTRAINT "student_academic_records_academicLevelId_fkey" FOREIGN KEY ("academicLevelId") REFERENCES "academic_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_academic_records" ADD CONSTRAINT "student_academic_records_academicGroupId_fkey" FOREIGN KEY ("academicGroupId") REFERENCES "academic_groups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_academic_records" ADD CONSTRAINT "student_academic_records_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "sections"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curriculum_subjects" ADD CONSTRAINT "curriculum_subjects_academicLevelId_fkey" FOREIGN KEY ("academicLevelId") REFERENCES "academic_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "curriculum_subjects" ADD CONSTRAINT "curriculum_subjects_academicGroupId_fkey" FOREIGN KEY ("academicGroupId") REFERENCES "academic_groups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exams" ADD CONSTRAINT "exams_academicSessionId_fkey" FOREIGN KEY ("academicSessionId") REFERENCES "academic_sessions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exams" ADD CONSTRAINT "exams_academicLevelId_fkey" FOREIGN KEY ("academicLevelId") REFERENCES "academic_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exams" ADD CONSTRAINT "exams_academicGroupId_fkey" FOREIGN KEY ("academicGroupId") REFERENCES "academic_groups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam_fees" ADD CONSTRAINT "exam_fees_examId_fkey" FOREIGN KEY ("examId") REFERENCES "exams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam_fees" ADD CONSTRAINT "exam_fees_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam_subjects" ADD CONSTRAINT "exam_subjects_examId_fkey" FOREIGN KEY ("examId") REFERENCES "exams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam_subjects" ADD CONSTRAINT "exam_subjects_curriculumSubjectId_fkey" FOREIGN KEY ("curriculumSubjectId") REFERENCES "curriculum_subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marks" ADD CONSTRAINT "marks_examSubjectId_fkey" FOREIGN KEY ("examSubjectId") REFERENCES "exam_subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marks" ADD CONSTRAINT "marks_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "marks" ADD CONSTRAINT "marks_enteredBy_fkey" FOREIGN KEY ("enteredBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_examFeeId_fkey" FOREIGN KEY ("examFeeId") REFERENCES "exam_fees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment_transactions" ADD CONSTRAINT "payment_transactions_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "payments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "results" ADD CONSTRAINT "results_examId_fkey" FOREIGN KEY ("examId") REFERENCES "exams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "results" ADD CONSTRAINT "results_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sections" ADD CONSTRAINT "sections_academicLevelId_fkey" FOREIGN KEY ("academicLevelId") REFERENCES "academic_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sections" ADD CONSTRAINT "sections_academicGroupId_fkey" FOREIGN KEY ("academicGroupId") REFERENCES "academic_groups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_subjects" ADD CONSTRAINT "student_subjects_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_subjects" ADD CONSTRAINT "student_subjects_studentAcademicRecordId_fkey" FOREIGN KEY ("studentAcademicRecordId") REFERENCES "student_academic_records"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_subjects" ADD CONSTRAINT "student_subjects_curriculumSubjectId_fkey" FOREIGN KEY ("curriculumSubjectId") REFERENCES "curriculum_subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teachers" ADD CONSTRAINT "teachers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teacher_assignments" ADD CONSTRAINT "teacher_assignments_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teacher_assignments" ADD CONSTRAINT "teacher_assignments_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "sections"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teacher_assignments" ADD CONSTRAINT "teacher_assignments_curriculumSubjectId_fkey" FOREIGN KEY ("curriculumSubjectId") REFERENCES "curriculum_subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teacher_assignments" ADD CONSTRAINT "teacher_assignments_academicSessionId_fkey" FOREIGN KEY ("academicSessionId") REFERENCES "academic_sessions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
