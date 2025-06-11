import { MdTravelExplore } from "react-icons/md"


interface IIpSectionProps{
    search: string
    ip: string
    whatweb_result: string
    render_whatweb?: boolean
}

export default function IpSection({ search, ip, whatweb_result, render_whatweb }: IIpSectionProps) {
    const title = "Identificação de Endereço IP"
    const subTitle = "OUTRAS INFORMAÇÕES RELACIONADAS AOS ENDEREÇAMENTOS IP DO ALVO:"

    return (
        <section className="mb-7">
            <h1 className="text-blue-500 text-2xl font-bold mb-5">{title}</h1>
            <div className="flex flex-row items-start">
                <MdTravelExplore className="text-blue-500 mr-3" size={30}/>
                <div className="text-white mb-5">
                    <p>Alias Pesquisado: {search}</p>
                    <p>Endereço IP Descoberto: {ip}</p>
                </div>
            </div>

            {render_whatweb && (
                <>
                    <p className="text-white mb-3">{subTitle}</p>
                    <pre className="text-white overflow-x-auto">{whatweb_result}</pre>
                </>
            )}
            </section>
    )
}
