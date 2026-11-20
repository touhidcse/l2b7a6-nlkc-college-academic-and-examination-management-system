import express, { Application, Request, Response } from "express";
// import express , {Application, Request, Response} from "express"
import config from "./config";
import cors from "cors"
import cookieParser from "cookie-parser";


const app: Application = express()


app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cookieParser())

app.get("/", (req: Request, res: Response) => {
    res.send("NLKC academic and result management")
})

// app.use(notFound)

// app.use(globalErrorHandler)

export default app;
