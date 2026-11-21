import app from "./app";
import config from "./config";
import { prisma } from "./lib/prisma";
import { seedAdmin, seedTesterStudent, seedTesterTeacher } from "./utils/seed";

const PORT = config.port;

const main = async () => {
	try {
		await prisma.$connect();
		console.log("Connected to the database successfully.");

		// await redisClient.connect();
		// console.log("Redis connected successfully");

		// await transporter.verify();
		// console.log("Nodemailer connected Successfully");


		await seedAdmin();
		await seedTesterTeacher();
		await seedTesterStudent();
		
		app.listen(PORT, () => {
			console.log(`Server is running on port ${PORT}`);
		});
	} catch (error) {
		console.error("Error starting the server:", error);
		await prisma.$disconnect();
		process.exit(1);
	}
};

main();
