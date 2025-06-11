import { Section } from "@/app/result/page"

type SectionButtonProps = {
    section: Section
    onSelect: (section: Section) => void
    isCurrent: boolean
}

export default function SectionButton({ section, onSelect, isCurrent }: SectionButtonProps){
    return (
        <button
            className={`p-5 text-white rounded-md border border-blue-500 grow ${isCurrent ? "bg-blue-500" : "bg-slate-700"}`}
            onClick={() => onSelect(section)}
        >
            {section.title}
        </button>
    )
}
