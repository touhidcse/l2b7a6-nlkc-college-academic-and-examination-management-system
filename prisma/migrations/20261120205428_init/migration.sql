-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'TEACHER', 'STUDENT');

-- CreateEnum
CREATE TYPE "ProgramType" AS ENUM ('HIGHER_SECONDARY', 'DEGREE', 'HONOURS');

-- CreateEnum
CREATE TYPE "GroupType" AS ENUM ('SCIENCE', 'BUSINESS_STUDIES', 'HUMANITIES', 'BA', 'BSS', 'BBS', 'ACCOUNTING', 'MANAGEMENT');

-- CreateEnum
CREATE TYPE "AcademicStatus" AS ENUM ('ACTIVE', 'COMPLETED', 'TRANSFERRED', 'DROPPED');

-- CreateEnum
CREATE TYPE "SubjectCategory" AS ENUM ('COMPULSORY', 'ELECTIVE', 'OPTIONAL');

-- CreateEnum
CREATE TYPE "PaperType" AS ENUM ('FIRST', 'SECOND', 'SINGLE');

-- CreateEnum
CREATE TYPE "SubjectName" AS ENUM ('BENGALI', 'ENGLISH', 'ICT', 'PHYSICS', 'CHEMISTRY', 'MATHEMATICS', 'BIOLOGY', 'ACCOUNTING', 'FINANCE_BANKING_INSURANCE', 'BUSINESS_ORGANIZATION_MANAGEMENT', 'STATISTICS', 'CIVICS', 'ISLAMIC_HISTORY_CULTURE', 'SOCIOLOGY', 'LOGIC', 'ISLAMIC_STUDIES', 'ECONOMICS', 'DEGREE_HEIV', 'DEGREE_ICT', 'DEGREE_ENGLISH', 'DEGREE_BENGALI', 'DEGREE_APPLIED_ICT', 'DEGREE_FUNCTIONAL_ENGLISH', 'DEGREE_ISLAMIC_HISTORY_CULTURE', 'DEGREE_ISLAMIC_STUDIES', 'DEGREE_LOGIC', 'DEGREE_POLITICAL_SCIENCE', 'DEGREE_SOCIOLOGY', 'DEGREE_ECONOMICS', 'DEGREE_ACCOUNTING', 'DEGREE_MANAGEMENT', 'HONOURS_HEIV', 'HONOURS_ICT', 'HONOURS_APPLIED_ICT', 'HONOURS_FUNCTIONAL_ENGLISH', 'HONOURS_ACCOUNTING', 'HONOURS_MANAGEMENT', 'HONOURS_ECONOMICS', 'HONOURS_STATISTICS');

-- CreateEnum
CREATE TYPE "ExamType" AS ENUM ('HSC_HALF_YEARLY', 'HSC_ANNUAL', 'HSC_PRE_TEST', 'HSC_TEST', 'INCOURSE_1', 'INCOURSE_2');

-- CreateEnum
CREATE TYPE "ExamResultStatus" AS ENUM ('DRAFT', 'PUBLISHED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'SUCCESS', 'FAILED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ExamFeeStatus" AS ENUM ('UNPAID', 'PAID', 'WAIVED');

-- CreateEnum
CREATE TYPE "PaymentGateway" AS ENUM ('BKASH', 'SSLCOMMERZ', 'STRIPE');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('BKASH', 'CARD', 'MOBILE_BANKING', 'OTHER');

-- CreateEnum
CREATE TYPE "Grade" AS ENUM ('A_PLUS', 'A', 'A_MINUS', 'B', 'C', 'D', 'F', 'g');

-- CreateTable
CREATE TABLE "academic_groups" (
    "id" SERIAL NOT NULL,
    "academicLevelId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "code" "GroupType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "academic_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "academic_levels" (
    "id" SERIAL NOT NULL,
    "programId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "yearNumber" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "academic_levels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "academic_programs" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "type" "ProgramType" NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "academic_programs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "student_academic_records" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "academicSessionId" INTEGER NOT NULL,
    "academicLevelId" INTEGER NOT NULL,
    "academicGroupId" INTEGER,
    "sectionId" INTEGER NOT NULL,
    "rollNumber" INTEGER,
    "registrationNumber" TEXT,
    "status" "AcademicStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "student_academic_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "academic_sessions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "academic_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT,
    "oldData" JSONB,
    "newData" JSONB,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "curriculum_subjects" (
    "id" SERIAL NOT NULL,
    "academicLevelId" INTEGER NOT NULL,
    "academicGroupId" INTEGER,
    "subject" "SubjectName" NOT NULL,
    "paperType" "PaperType" NOT NULL DEFAULT 'SINGLE',
    "category" "SubjectCategory" NOT NULL,
    "selectionGroup" TEXT,
    "isRequired" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "curriculum_subjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exams" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "examType" "ExamType" NOT NULL,
    "academicSessionId" INTEGER NOT NULL,
    "academicLevelId" INTEGER NOT NULL,
    "academicGroupId" INTEGER,
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),
    "resultPublished" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "exams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exam_fees" (
    "id" SERIAL NOT NULL,
    "examId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "dueDate" TIMESTAMP(3),
    "status" "ExamFeeStatus" NOT NULL DEFAULT 'UNPAID',
    "paidAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "exam_fees_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exam_subjects" (
    "id" SERIAL NOT NULL,
    "examId" INTEGER NOT NULL,
    "curriculumSubjectId" INTEGER NOT NULL,
    "subject" "SubjectName" NOT NULL,
    "paperType" "PaperType" NOT NULL,
    "fullMarks" INTEGER NOT NULL,
    "mcqFullMarks" INTEGER,
    "creativeFullMarks" INTEGER,
    "practicalFullMarks" INTEGER,
    "mcqPassMarks" INTEGER,
    "creativePassMarks" INTEGER,
    "practicalPassMarks" INTEGER,
    "passMarks" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "exam_subjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marks" (
    "id" SERIAL NOT NULL,
    "examSubjectId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "mcqMark" INTEGER,
    "creativeMark" INTEGER,
    "practicalMark" INTEGER,
    "obtainedMark" INTEGER NOT NULL,
    "isPassed" BOOLEAN NOT NULL,
    "grade" "Grade",
    "gradePoint" DOUBLE PRECISION,
    "enteredBy" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "marks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" SERIAL NOT NULL,
    "examFeeId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "gateway" "PaymentGateway" NOT NULL,
    "paymentMethod" "PaymentMethod" NOT NULL,
    "status" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "gatewayTransactionId" TEXT,
    "initiatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_transactions" (
    "id" SERIAL NOT NULL,
    "paymentId" INTEGER NOT NULL,
    "gateway" "PaymentGateway" NOT NULL,
    "gatewayTransactionId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "status" "PaymentStatus" NOT NULL,
    "responseData" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payment_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "results" (
    "id" SERIAL NOT NULL,
    "examId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,
    "totalMarks" INTEGER NOT NULL,
    "obtainedMarks" INTEGER NOT NULL,
    "gpa" DOUBLE PRECISION,
    "status" "ExamResultStatus" NOT NULL DEFAULT 'DRAFT',
    "publishedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "results_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sections" (
    "id" SERIAL NOT NULL,
    "academicLevelId" INTEGER NOT NULL,
    "academicGroupId" INTEGER,
    "name" TEXT NOT NULL,
    "capacity" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "students" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "studentId" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3),
    "gender" TEXT,
    "guardianName" TEXT,
    "guardianPhone" TEXT,
    "address" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "students_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "student_subjects" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "studentAcademicRecordId" INTEGER NOT NULL,
    "curriculumSubjectId" INTEGER NOT NULL,
    "subject" "SubjectName" NOT NULL,
    "paperType" "PaperType" NOT NULL,
    "category" "SubjectCategory" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "student_subjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teachers" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "employeeId" TEXT NOT NULL,
    "designation" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "teachers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teacher_assignments" (
    "id" SERIAL NOT NULL,
    "teacherId" INTEGER NOT NULL,
    "sectionId" INTEGER NOT NULL,
    "curriculumSubjectId" INTEGER NOT NULL,
    "academicSessionId" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "teacher_assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT,
    "name" TEXT NOT NULL,
    "phone" TEXT,
    "role" "Role" NOT NULL DEFAULT 'STUDENT',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "academic_groups_academicLevelId_idx" ON "academic_groups"("academicLevelId");

-- CreateIndex
CREATE UNIQUE INDEX "academic_groups_academicLevelId_code_key" ON "academic_groups"("academicLevelId", "code");

-- CreateIndex
CREATE INDEX "academic_levels_programId_idx" ON "academic_levels"("programId");

-- CreateIndex
CREATE UNIQUE INDEX "academic_levels_programId_yearNumber_key" ON "academic_levels"("programId", "yearNumber");

-- CreateIndex
CREATE UNIQUE INDEX "academic_programs_code_key" ON "academic_programs"("code");

-- CreateIndex
CREATE INDEX "academic_programs_type_idx" ON "academic_programs"("type");

-- CreateIndex
CREATE INDEX "academic_programs_isActive_idx" ON "academic_programs"("isActive");

-- CreateIndex
CREATE INDEX "student_academic_records_studentId_idx" ON "student_academic_records"("studentId");

-- CreateIndex
CREATE INDEX "student_academic_records_academicSessionId_idx" ON "student_academic_records"("academicSessionId");

-- CreateIndex
CREATE INDEX "student_academic_records_academicLevelId_idx" ON "student_academic_records"("academicLevelId");

-- CreateIndex
CREATE INDEX "student_academic_records_sectionId_idx" ON "student_academic_records"("sectionId");

-- CreateIndex
CREATE INDEX "student_academic_records_status_idx" ON "student_academic_records"("status");

-- CreateIndex
CREATE UNIQUE INDEX "student_academic_records_studentId_academicSessionId_academ_key" ON "student_academic_records"("studentId", "academicSessionId", "academicLevelId");

-- CreateIndex
CREATE UNIQUE INDEX "academic_sessions_name_key" ON "academic_sessions"("name");

-- CreateIndex
CREATE INDEX "academic_sessions_isActive_idx" ON "academic_sessions"("isActive");

-- CreateIndex
CREATE INDEX "audit_logs_userId_idx" ON "audit_logs"("userId");

-- CreateIndex
CREATE INDEX "audit_logs_entity_entityId_idx" ON "audit_logs"("entity", "entityId");

-- CreateIndex
CREATE INDEX "audit_logs_action_idx" ON "audit_logs"("action");

-- CreateIndex
CREATE INDEX "audit_logs_createdAt_idx" ON "audit_logs"("createdAt");

-- CreateIndex
CREATE INDEX "curriculum_subjects_academicLevelId_idx" ON "curriculum_subjects"("academicLevelId");

-- CreateIndex
CREATE INDEX "curriculum_subjects_academicGroupId_idx" ON "curriculum_subjects"("academicGroupId");

-- CreateIndex
CREATE INDEX "curriculum_subjects_subject_idx" ON "curriculum_subjects"("subject");

-- CreateIndex
CREATE INDEX "curriculum_subjects_category_idx" ON "curriculum_subjects"("category");

-- CreateIndex
CREATE UNIQUE INDEX "curriculum_subjects_academicLevelId_academicGroupId_subject_key" ON "curriculum_subjects"("academicLevelId", "academicGroupId", "subject", "paperType");

-- CreateIndex
CREATE INDEX "exams_academicSessionId_idx" ON "exams"("academicSessionId");

-- CreateIndex
CREATE INDEX "exams_academicLevelId_idx" ON "exams"("academicLevelId");

-- CreateIndex
CREATE INDEX "exams_academicGroupId_idx" ON "exams"("academicGroupId");

-- CreateIndex
CREATE INDEX "exams_examType_idx" ON "exams"("examType");

-- CreateIndex
CREATE INDEX "exams_resultPublished_idx" ON "exams"("resultPublished");

-- CreateIndex
CREATE INDEX "exam_fees_examId_idx" ON "exam_fees"("examId");

-- CreateIndex
CREATE INDEX "exam_fees_studentId_idx" ON "exam_fees"("studentId");

-- CreateIndex
CREATE INDEX "exam_fees_status_idx" ON "exam_fees"("status");

-- CreateIndex
CREATE UNIQUE INDEX "exam_fees_examId_studentId_key" ON "exam_fees"("examId", "studentId");

-- CreateIndex
CREATE INDEX "exam_subjects_examId_idx" ON "exam_subjects"("examId");

-- CreateIndex
CREATE INDEX "exam_subjects_curriculumSubjectId_idx" ON "exam_subjects"("curriculumSubjectId");

-- CreateIndex
CREATE INDEX "exam_subjects_subject_idx" ON "exam_subjects"("subject");

-- CreateIndex
CREATE UNIQUE INDEX "exam_subjects_examId_curriculumSubjectId_key" ON "exam_subjects"("examId", "curriculumSubjectId");

-- CreateIndex
CREATE INDEX "marks_studentId_idx" ON "marks"("studentId");

-- CreateIndex
CREATE INDEX "marks_examSubjectId_idx" ON "marks"("examSubjectId");

-- CreateIndex
CREATE INDEX "marks_isPassed_idx" ON "marks"("isPassed");

-- CreateIndex
CREATE UNIQUE INDEX "marks_examSubjectId_studentId_key" ON "marks"("examSubjectId", "studentId");

-- CreateIndex
CREATE INDEX "payments_examFeeId_idx" ON "payments"("examFeeId");

-- CreateIndex
CREATE INDEX "payments_studentId_idx" ON "payments"("studentId");

-- CreateIndex
CREATE INDEX "payments_status_idx" ON "payments"("status");

-- CreateIndex
CREATE INDEX "payments_gateway_idx" ON "payments"("gateway");

-- CreateIndex
CREATE INDEX "payments_gatewayTransactionId_idx" ON "payments"("gatewayTransactionId");

-- CreateIndex
CREATE INDEX "payment_transactions_paymentId_idx" ON "payment_transactions"("paymentId");

-- CreateIndex
CREATE INDEX "payment_transactions_gatewayTransactionId_idx" ON "payment_transactions"("gatewayTransactionId");

-- CreateIndex
CREATE INDEX "payment_transactions_status_idx" ON "payment_transactions"("status");

-- CreateIndex
CREATE INDEX "results_studentId_idx" ON "results"("studentId");

-- CreateIndex
CREATE INDEX "results_examId_idx" ON "results"("examId");

-- CreateIndex
CREATE INDEX "results_status_idx" ON "results"("status");

-- CreateIndex
CREATE UNIQUE INDEX "results_examId_studentId_key" ON "results"("examId", "studentId");

-- CreateIndex
CREATE INDEX "sections_academicLevelId_idx" ON "sections"("academicLevelId");

-- CreateIndex
CREATE INDEX "sections_academicGroupId_idx" ON "sections"("academicGroupId");

-- CreateIndex
CREATE INDEX "sections_isActive_idx" ON "sections"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "sections_academicLevelId_academicGroupId_name_key" ON "sections"("academicLevelId", "academicGroupId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "students_userId_key" ON "students"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "students_studentId_key" ON "students"("studentId");

-- CreateIndex
CREATE INDEX "students_studentId_idx" ON "students"("studentId");

-- CreateIndex
CREATE INDEX "students_deletedAt_idx" ON "students"("deletedAt");

-- CreateIndex
CREATE INDEX "student_subjects_studentId_idx" ON "student_subjects"("studentId");

-- CreateIndex
CREATE INDEX "student_subjects_studentAcademicRecordId_idx" ON "student_subjects"("studentAcademicRecordId");

-- CreateIndex
CREATE INDEX "student_subjects_curriculumSubjectId_idx" ON "student_subjects"("curriculumSubjectId");

-- CreateIndex
CREATE INDEX "student_subjects_subject_idx" ON "student_subjects"("subject");

-- CreateIndex
CREATE INDEX "student_subjects_category_idx" ON "student_subjects"("category");

-- CreateIndex
CREATE UNIQUE INDEX "student_subjects_studentAcademicRecordId_subject_paperType_key" ON "student_subjects"("studentAcademicRecordId", "subject", "paperType");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_userId_key" ON "teachers"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_employeeId_key" ON "teachers"("employeeId");

-- CreateIndex
CREATE INDEX "teachers_employeeId_idx" ON "teachers"("employeeId");

-- CreateIndex
CREATE INDEX "teachers_deletedAt_idx" ON "teachers"("deletedAt");

-- CreateIndex
CREATE INDEX "teacher_assignments_teacherId_idx" ON "teacher_assignments"("teacherId");

-- CreateIndex
CREATE INDEX "teacher_assignments_sectionId_idx" ON "teacher_assignments"("sectionId");

-- CreateIndex
CREATE INDEX "teacher_assignments_curriculumSubjectId_idx" ON "teacher_assignments"("curriculumSubjectId");

-- CreateIndex
CREATE INDEX "teacher_assignments_academicSessionId_idx" ON "teacher_assignments"("academicSessionId");

-- CreateIndex
CREATE INDEX "teacher_assignments_isActive_idx" ON "teacher_assignments"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "teacher_assignments_teacherId_sectionId_curriculumSubjectId_key" ON "teacher_assignments"("teacherId", "sectionId", "curriculumSubjectId", "academicSessionId");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_role_idx" ON "users"("role");

-- CreateIndex
CREATE INDEX "users_isActive_idx" ON "users"("isActive");

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
