import { ButtonHTMLAttributes } from "react"

type CustomButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
    isLoading?: boolean
}

export function CustomButton({ children, className, isLoading, ...props }: CustomButtonProps) {
    const classes = "text-white bg-gradient-to-r from-cyan-500 to-purple-700 items-center w-fit p-3"
        + " rounded-md flex flex-row disabled:bg-slate-700 disabled:bg-none disabled:text-slate-400"
        + ` ${className}`

    return (
        <button
            className={classes}
            type="button"
            {...props}
        >
            {children}
        </button>
    );
}
